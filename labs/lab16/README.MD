# Сбор и анализ логов

**Цель домашнего задания**

Научится проектировать централизованный сбор логов. Рассмотреть особенности разных платформ для сбора логов.

**Описание домашнего задания**

* В Vagrant разворачиваем 2 виртуальные машины web и log
* На web настраиваем nginx
* На log настраиваем центральный лог сервер на любой системе на выбор
    * journald
    * rsyslog
    * elk
* Настраиваем аудит, следящий за изменением конфигов nginx 

Все критичные логи с web должны собираться и локально и удаленно.
Все логи с nginx должны уходить на удаленный сервер (локально только критичные).
Логи аудита должны также уходить на удаленную систему.

Формат сдачи ДЗ - vagrant + ansible

* Дополнительное задание
    * развернуть еще машину с elk
    * таким образом настроить 2 центральных лог системы elk и какую либо еще;
    * в elk должны уходить только логи нжинкса;
    * во вторую систему все остальное.

**Решение**

**Создаём виртуальные машины**

```
vagrant init cenros/7
vi Vagrantfile
vagrant up
```

```
vagrant ssh web
sudo -i
cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime
systemctl restart chronyd
systemctl status chronyd
```
![Alt text](image.png)

```
yum install -y vim
```

```
vagrant ssh log
sudo -i
yum install -y vim
cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime
systemctl restart chronyd
systemctl status chronyd
```
![Alt text](image-1.png)

**Установка nginx на виртуальной машине web**

```
yum install epel-release 
```
![Alt text](image-2.png)

```
yum install -y nginx
```
![Alt text](image-3.png)

```
systemctl start nginx
systemctl status nginx
```
![Alt text](image-4.png)
![Alt text](image-5.png)

**Настройка центрального сервера сбора логов**

```
vagrant ssh log
sudo -i
yum list rsyslog
```
![Alt text](image-6.png)

```
vi /etc/rsyslog.conf
```
![Alt text](image-7.png)
![Alt text](image-8.png)

```
sytemctl restart rsyslog
ss -tunl
```
![Alt text](image-9.png)

```
vagrant ssh web
sudo -i
rpm -qa | grep nginx
```
![Alt text](image-10.png)

```
vi etc/nginx/nginx.conf
```
![Alt text](image-12.png)

```
nginx -t
```
![Alt text](image-13.png)

```
reboot
```

```
rm /usr/share/nginx/html/img/header-background.png
```

```
cat /var/log/rsyslog/web/nginx_access.log
```
![Alt text](image-14.png)

```
cat /var/log/rsyslog/web/nginx_error.log 
```
![Alt text](image-15.png)

**Настройка аудита, контролирующего изменения конфигурации nginx**

```
rpm -qa | grep audit
```
![Alt text](image-16.png)

```
vi /etc/audit/rules.d/audit.rules
```
![Alt text](image-17.png)

```
service auditd restart
```

```
vi /etc/nginx/nginx.conf
grep nginx_conf /var/log/audit/audit.log
```
![Alt text](image-18.png)

```
yum -y install audispd-plugins
```
![Alt text](image-19.png)

```
vi /etc/audit/auditd.conf
```
![Alt text](image-26.png)

```
vi /etc/audisp/plugins.d/au-remote.conf
```
![Alt text](image-20.png)

```
vi /etc/audisp/audisp-remote.conf
```
![Alt text](image-21.png)

```
vi /etc/audit/auditd.conf
```
![Alt text](image-25.png)

```
service auditd restart
```
![Alt text](image-23.png)

```
ls -l /etc/nginx/nginx.conf
chmod +x /etc//nginx/nginx.conf
ls -l /etc/nginx/nginx.conf
```
![Alt text](image-24.png)

```
grep web /var/log/audit/audit.log
```















