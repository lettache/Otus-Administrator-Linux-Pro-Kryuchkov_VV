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































