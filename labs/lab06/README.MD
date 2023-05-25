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































