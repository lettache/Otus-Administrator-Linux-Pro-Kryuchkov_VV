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

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/c17310a4-3379-4c70-8d0a-ee6c5a252567)

```
vagrant box add centos-7-kernel15 centos-7-kernel-5-x86_64-Minimal.box
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/fb17d505-8ce2-436d-b5b0-20b0a8831cef)

```
vagrant box list
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/3b4df201-6d51-46ac-bea7-0c72140a30d9)

```
vagrant init centos-7-kernel15
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/134d27ea-f383-46d0-8053-f960e1396bf2)

```
vagrant up
vagrant ssh
uname -r
```

```
vagrant cloud auth login
```

```
vagrant cloud publish --release VladimirKru/centos-7-kernel5 1.0 virtualbox centos-7-kernel-5-x86_64-Minimal.box
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/07b64c46-8b20-4e6f-b849-5a308334be83)















