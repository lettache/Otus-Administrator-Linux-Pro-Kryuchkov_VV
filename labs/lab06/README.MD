# Создание RPM пакета

**Задачи:**

  *1. Создать свой RPM пакет (можно взять свое приложение, либо собрать, например,
апач с определенными опциями)*
  
  *2. Создать свой репозиторий и разместить там ранее собранный RPM*
   
**Решение:**

**Создать свой RPM пакет**

```
vagrant init centos/7
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

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/eb91aeab-bb70-46de-8904-99cf3e8e7a16)

```
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.20.2-1.el7.ngx.src.rpm
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/25e186d5-d005-4236-918f-a4ae9d3bbad2)

```
rpm -i nginx-1.*
```

```
wget https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/5cec2a67-0914-4e8a-ac3e-80d7f240ec0f)


```
wget https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip
unzip OpenSSL_1_1_1-stable.zip
yum-builddep rpmbuild/SPECS/nginx.spec
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/7297e03a-b30f-4cc2-8635-d9aecf17f212)

























