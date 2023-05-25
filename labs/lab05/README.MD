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

**Настраиваем сервер NFS**

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
exit
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/8d3df634-d94f-438b-8ffa-0f7456368d38)

**Настраиваем клиент NFS**

```
vagrant ssh nfsc
su
```
```
yum install nfs-utils 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/bce46ccd-f88b-4e86-812c-ea200fc6f26a)

```
systemctl enable firewalld --now 
systemctl status firewalld 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/1d3c3af8-c9c2-4898-8a2f-ed897a78a4bb)

```
echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0" >> /etc/fstab
```

```
systemctl daemon-reload 
systemctl restart remote-fs.target
```

```
mount | grep mnt
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/a5228bd3-60a9-41cb-9b74-c9abd3db5ef7)

**Проверка работоспособности**

```
vagrant ssh nfss
cd /srv/share/upload
touch check_file
exit
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/640944ed-fb95-4ad7-a97f-e5ffb0ec6e50)

```
vagrant ssh nfsc
cd /mnt/upload
ls
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/f2fd6465-fb19-4bb0-83d8-393d241dfa7e)

```
touch client_file
ls
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/da45624e-702d-44c9-9853-cc97922a8627)

**Предварительно проверяем клиент**

```
reboot
vagrant ssh nfsc
su
cd /mnt/upload
ls
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/703f6405-4eda-4bc4-95da-2f55a1369e38)

**Проверяем сервер**

```
reboot
vagrant ssh nfss
su
ls /srv/share/upload/
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/f69a5821-33d5-4b7d-b18c-045e9c760ba1)

```
systemctl status nfs
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/0ccc5bf0-56db-4c44-8b3c-262eb8a8cd53)

```
systemctl status firewalld
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/ae4e7a7b-7daf-4422-a6af-1b9cbeaf5f6c)

```
exportfs -s
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/b8211fe4-9451-4cda-ac83-d6769c056332)

```
showmount -a 192.168.50.10
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/8352c22b-2404-4b0a-b9fa-be263dd6966e)

**Проверяем клиент**

```
reboot
vagrant ssh nfsc
su
showmount -a 192.168.50.10
cd /mnt/upload
mount | grep mnt
ls
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/8c059dfc-547d-4ae1-b9db-48d17453fe28)

```
touch final_check
ls
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/1cec6aeb-264b-473c-b4bb-e55f5c3d64e9)





