# Стенд Vagrant с NFS

**Задачи:**

  *1. `vagrant up` должен поднимать 2 настроенных виртуальных машины (сервер NFS и клиента) без дополнительных ручных действий; - на сервере NFS должна быть подготовлена и экспортирована директория*
  
  *2. В экспортированной директории должна быть поддиректория с именем __upload__ с правами на запись в неё*
  
  *3. Экспортированная директория должна автоматически монтироваться на клиенте при старте виртуальной машины (systemd, autofs или fstab -  любым способом)*
  
  *4. Монтирование и работа NFS на клиенте должна быть организована с использованием NFSv3 по протоколу UDP*
  
  *5. Firewall должен быть включен и настроен как на клиенте, так и на сервере*
 
 Для самостоятельной реализации: 
 
 *настроить аутентификацию через KERBEROS с использованием NFSv4*

**Решение:**

```
vagrant box add centos/7 --provider virtualbox --box version 2004.01 --clean
```

**Создаём тестовые виртуальные машины**

```
vagrant up
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/35e1dbe6-c66f-4295-a34b-210d114913a1)

```
vagrant ssh nfss
su
```

```
yum install nfs-utils 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/7bf35215-d899-471c-855c-bad2cffc074f)














