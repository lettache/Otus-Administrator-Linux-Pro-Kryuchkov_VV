# Создание RPM пакета

**Задачи:**

  *1. Создать свой RPM пакет (можно взять свое приложение, либо собрать, например,
апач с определенными опциями)*
  
  *2. Создать свой репозиторий и разместить там ранее собранный RPM*
   
**Решение:**

**Создать свой RPM пакет**

```
vagrant init generic/centos8s
vagrant up
vagrant ssh
```

```
yum install -y \
redhat-lsb-core \
wget \
rpmdevtools \
rpm-build \
createrepo \
yum-utils \
gcc
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/6196f173-1082-408a-a293-709bfa005a50)

```
wget https://nginx.org/packages/centos/8/SRPMS/nginx-1.20.2-1.el8.ngx.src.rpm
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/cc38f01c-0d60-479d-8422-a1389dc59167)

```
rpm -i nginx-1.*
```

```
wget https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/014a2032-8063-42e7-9328-320101c69af7)

```
unzip OpenSSL_1_1_1-stable.zip
yum-builddep rpmbuild/SPECS/nginx.spec
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/508fed4e-18f7-45f2-8d20-83e343c6a057)

```
rpmbuild -bb rpmbuild/SPECS/nginx.spec
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/285e1594-1065-423a-a8da-c67e582c7af1)

```
ll rpmbuild/RPMS/x86_64/
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/ad7befd2-a31a-48dd-baf9-9cce87ea22bf)

```
sudo yum localinstall -y rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el8.ngx.x86_64.rpm
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/9a781a04-e856-42a6-8c82-e4efbe38e39e)

```
systemctl start nginx
systemctl status nginx
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/447d30a9-ba37-4478-ae35-56d6eff6dc13)

```

```















