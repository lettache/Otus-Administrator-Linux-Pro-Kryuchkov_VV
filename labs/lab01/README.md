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
vagrant init ubuntu/focal64
```

![image](https://user-images.githubusercontent.com/84719218/235877918-dbbdbea1-e3d1-4d2f-a8eb-05b874db503c.png)

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

![image](https://user-images.githubusercontent.com/84719218/235879544-1b3ad04f-01c0-47fe-96c6-a90ba0e694e3.png)

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




