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

**Создать свой репозиторий и разместить там ранее собранный RPM**

```
mkdir /usr/share/nginx/html/repo
cp rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/
```

```
wget
https://downloads.percona.com/downloads/percona-distribution-mysql-ps/percona-distribution-mysql-ps-8.0.28/binary/redhat/8/x86_64/percona-orchestrator-3.2.6-2.el8.x86_64.rpm -O /usr/share/nginx/html/repo/percona-orchestrator-3.2.6-2.el8.x86_64.rpm
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/0bd73340-3918-4a6d-ad15-6ccbfe7c19d1)

```
createrepo /usr/share/nginx/html/repo/
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/87c1727a-e6fa-4cdd-8cba-9c43012f2e84)

```
vi /etc/nginx/conf.d/default.conf
```

```
nginx -t
nginx -s reload
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d1397fcb-f837-4b63-8317-6289ffc336e6)

```
curl -a http://localhost/repo/
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/38ab3336-8075-4e18-8a85-4aea2c2b3cb4)

```
cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
```

```
yum repolist enabled | grep otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/c8e449ec-4702-4c64-a970-1248fad75286)

```
yum list | grep otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/f01ef964-72af-44c5-8290-ef4daa1462d1)

```
yum install percona-orchestrator.x86_64 -y
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/f13bf0d9-7560-4431-9d0e-50158a4c50e3)
