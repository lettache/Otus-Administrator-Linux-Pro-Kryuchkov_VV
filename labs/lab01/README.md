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
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/4c047a55-3fca-4f85-b7da-785d9c82523e)

```
sudo yum install https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
```

```
sudo yum --enablerepo elrepo-kernel install kernel-ml -y
```

```
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo grub2-set-default 0
sudo reboot
```

```
uname -r
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/422200f4-23c2-4494-875b-1930381c7dc1)

**2. Создать Vagrant box c помощью Packer**

```
mkdir packer
cd packer
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/b927030f-e82b-4c62-a5c3-06c0d1c28b62)

```
mkdir http
cd http
mcedit ks.cfg
```

```
cd ..
mkdir scripts
cd scripts
mcedit stage-1-kernel-update.sh
mcedit stage-2-clean.sh
```

```
cd ..
packer build centos.json
```

1








