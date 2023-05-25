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

```
systemctl enable firewalld --now
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/181abe01-ab37-499c-9b7d-2c90e9cf6334)

```
firewall-cmd --add-service="nfs3" \
--add-service="rpc-bind" \
--add-service="mountd" \
--permanent 
firewall-cmd --reload
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/3f364e0f-e296-45e3-b502-e346e537eb74)

```
systemctl enable nfs --now
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/b86481e2-1b52-4844-8858-506a612e0edb)

```
ss -tnplu
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d268ea92-70fa-4780-b11a-3ab203dc4742)

```
mkdir -p /srv/share/upload 
chown -R nfsnobody:nfsnobody /srv/share 
chmod 0777 /srv/share/upload
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d5891415-4402-4b97-8f86-69264ef6d37e)

```
cat << EOF > /etc/exports 
/srv/share 192.168.50.11/32(rw,sync,root_squash) 
EOF
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/57a7b47d-d35d-4144-9be3-e0f82c82d92a)

```
exportfs -r
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/54cbf422-1d4c-48de-9853-b22ea3fd25a4)

```
exportfs -s
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/8d3df634-d94f-438b-8ffa-0f7456368d38)

**Настраиваем клиент NFS**



























