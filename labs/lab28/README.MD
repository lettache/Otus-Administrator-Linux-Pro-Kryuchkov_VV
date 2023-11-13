# Vagrant-стенд c Postgres

## Цели домашнего задания

Научиться настраивать репликацию и создавать резервные копии в СУБД PostgreSQL

## Описание домашнего задания

1) Настроить hot_standby репликацию с использованием слотов
2) Настроить правильное резервное копирование

пример плейбука:

```bash
- name: Установка postgres11
  hosts: master, slave
  become: yes
  roles:
   - postgres_install

- name: Настройка master
  hosts: master
  become: yes
  roles:
   - master-setup
```

## Введение

PostgreSQL — свободная объектно-реляционная система управления базами данных (СУБД). 
Основные термины в Postgres:
**Кластер** - объединение нескольких баз данных. В postgres это означает что на одном хосте создаётся несколько баз сразу. 
**База данных** - физическое объединение объектов
**Схема** - логическое объединение таблиц в базе данных. По умолчанию в postgres создаётся одна схема под названием Public
**По умолчанию в кластере находятся:**
- **template0** - read only БД, содержащая инициализационный набор данных
- **template1** - база-шаблон для создания новых баз
- **postgres** (при желании можно поменять название). В базе находятся служебные таблицы, можно также использовать данную базу для своих нужд, но это не рекомендуется.

Управлять базами, таблицами и данными можно не только с помощью консольной утилиты psql, но и с помощью GUI-утилит, например pgAdmin, Dbeaver  и т. д.

Postgres - это мультироцессное приложение. Состоит из главного процесса (postgres), который отвечает за подключение клиентов, взаимодействие с кэшом и отвечает за остальные процессы (background processes).

![Alt text](image.png)

Основные конфигурационные файлы в Postgres: 
* **pg_hba.conf** -  файл задаёт способ доступа к базам и репликации из различных источников.
* **postgresql.conf** - файл конфигурации, обычно находится в каталоге данных, может редактироваться вручную. Может быть несколько значений одного и того же параметра, тогда вступает в силу последнее значение.
* **postgresql.auto.conf** - предназначен для автоматического изменения параметров postgres

**WAL (Write Ahead Log)** - журнал упреждающей записи
В WAL записывается информация, достаточная для повторного выполнения всех действий с БД.
Записи этого журнала обязаны попасть на диск раньше, чем изменения в соответствующей странице. Журнал состоит из нескольких файлов (обычно по 16МБ), которые циклически перезаписываются.

**Репликация** - процесс синхронизации нескольких копий одного объекта. Решает задачу отказоустойчивости и масштабируемости.

**Задачи репликации:**
* балансировка нагрузки
* резервирование (НЕ БЭКАП, бэкап можно делать с реплики)
* обновление без остановки системы
* горизонтальное масштабирование
* геораспределение нагрузки

**Виды репликации:**
* **Физическая репликация** - описание изменений на уровне файлов. Побайтовая копия данных.
* **Логическая репликация** - изменения данных в терминах строк таблиц. Более высокий уровень, чем файлы

Помимо репликации, рекомендуется создавать резервные копии. Они могут потребоваться, если вдруг сервера СУБД выйдут из строя. 

## Решение

Создадим Vagrantfile, в котором будут указаны параметры наших ВМ:

```bash
# Описание параметров ВМ
MACHINES = {
  # Имя DV "pam"
  :node1 => {
        # VM box
        :box_name => "centos/stream8",
        # Имя VM
        :vm_name => "node1",
        # Количество ядер CPU
        :cpus => 2,
        # Указываем количество ОЗУ (В Мегабайтах)
        :memory => 1024,
        # Указываем IP-адрес для ВМ
        :ip => "192.168.57.11",
  },
  :node2 => {
        :box_name => "centos/stream8",
        :vm_name => "node2",
        :cpus => 2,
        :memory => 1024,
        :ip => "192.168.57.12",

  },
  :barman => {
        :box_name => "centos/stream8",
        :vm_name => "barman",
        :cpus => 1,
        :memory => 1024,
        :ip => "192.168.57.13",

  },

}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|
    
    config.vm.define boxname do |box|
   
      box.vm.box = boxconfig[:box_name]
      box.vm.host_name = boxconfig[:vm_name]
      box.vm.network "private_network", ip: boxconfig[:ip]
      box.vm.provider "virtualbox" do |v|
        v.memory = boxconfig[:memory]
        v.cpus = boxconfig[:cpus]
      end

      # Запуск ansible-playbook
      if boxconfig[:vm_name] == "barman"
       box.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/provision.yml"
        ansible.inventory_path = "ansible/hosts"
        ansible.host_key_checking = "false"
        ansible.limit = "all"
       end
      end
    end
  end
end
```

После создания Vagrantfile запустим наши ВМ командой vagrant up. Будет создано три виртуальных машины.

```bash
vagrant up
```

На всех хостах предварительно должны быть выключены firewalld и SElinux:
- Отключаем службу firewalld:  ```systemctl stop firewalld```
- Удаляем службу из автозагрузки: ```systemctl disable firewalld```
- Отключаем SElinux: ```setenforce 0```
- Правим параметр SELINUX=disabled в файле /etc/selinux/config 

Для удобства на все хосты можно установить текстовый редактор vim и утилиту telnet: 
```bash 
yum install -y vim telnet
```

Команды должны выполняться от root-пользователя
Для перехода в root-пользователя вводим sudo -i

**Настройка hot_standby репликации с использованием слотов**

Перед настройкой репликации необходимо установить postgres-server на хосты node1 и node2:

1) Добавим postgres репозиторий: ```sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm```
2) Исключаем старый postgresql модуль: ```yum -qy module disable postgresql```
3) Устанавливаем postgresql-server 14: ```yum install -y postgresql14-server```
4) Выполняем инициализацию кластера: ```sudo /usr/pgsql-14/bin/postgresql-14-setup initdb```
5) Запускаем postgresql-server: ```systemctl start postgresql-14```
6) Добавляем postgresql-server в автозагрузку:  ```systemctl enable postgresql-14```




