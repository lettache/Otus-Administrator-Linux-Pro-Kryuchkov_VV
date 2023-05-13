# Vagrant-стенд для обновления ядра и создания образа системы

**Задачи:**

  *1. Обновить ядро ОС из репозитория ELRepo*
  
  *2. Создать Vagrant box c помощью Packer*

  *3. Загрузить Vagrant box в Vagrant Cloud*
  
   *Дополнительные задания:*
   - Ядро собрано из исходников
   - В образе нормально работают VirtualBox Shared Folders

**Решение:**

**1. Обновить ядро ОС**

```
vagrant init centos/7
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/79866c1a-c124-49d6-a217-191141c68d83)

```
mcedit Vagrantfile
```

```
vagrant up
```

```
vagrant ssh 
```

```
uname -r
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/ed9430dd-59f2-4b83-92d1-f54630b05e8e)

```
sudo apt-get install build-essential kernel-package libncurses-dev flex bison libssl-dev libelf-dev dwarves
```

```
sudo wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.9.tar.gz
```

```
sudo tar xf linux-5.9.tar.gz 
```

```
cd linux-5.9/
sudo make oldconfig
```

```
sudo make-kpkg clean
sudo scripts/config --disable SYSTEM_TRUSTED_KEYS
sudo scripts/config --disable SYSTEM_REVOCATION_KEYS
sudo make
```




