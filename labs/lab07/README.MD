# Работа с загрузчиком

**Задачи:**

  *1. Попасть в систему без пароля несколькими способами*
  
  *2. Установить систему с LVM, после чего переименовать VG*
  
  *3. Добавить модуль в initrd*
   
**Решение:**

**Попасть в систему без пароля несколькими способами**

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/6386d071-a932-4e94-ba8b-8b56c3535448)
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/bd75a191-4bb9-4886-9277-00f6ed6eaea8)

**Способ 1. init=/bin/sh**

```
init=/bin/sh
```
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/a8cd2490-d364-43db-b7ea-45faf8faa49a)

```
mount -o remount,rw /
mount | grep root
```
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d1ed3647-bced-4853-8c38-800e13571f04)

**Способ 2. rd.break**

```
rd.break
```
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/52dc7b89-8a31-425f-9af4-f61c7a8d2267)

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/09ab978a-d133-4783-820b-a81a92fed063)

```
mount -o remount,rw /sysroot
chroot /sysroot
passwd root
touch /.autorelabel
```
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d5854237-c5aa-49ac-9243-976c74569fb0)

**Способ 3. rw init=/sysroot/bin/sh**

```
rw init=/sysroot/bin/sh
```
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/3b909ccf-685a-4b5e-a8ce-5b2883816e2a)

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/9ab7643c-c019-41b1-a8bf-c6bdfbb328d7)

**Установить систему с LVM, после чего переименовать VG**

```
vgs
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/9c58f5d3-5180-4ca4-b5d8-720f0a5b02b7)

```
sudo vgrename cs_centos8s OtusRoot
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/dbf340a0-5bb8-45a8-925c-02816f8c50aa)

```
sudo vi /etc/fstab
sudo vi /etc/default/grub
sudo vi /boot/grub2/grub.cfg
```

```
sudo mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/e3edefb6-ecb2-447a-b356-6de3cd8b246d)

```
sudo reboot
```

```
vgs
```

**Добавить модуль в initrd**

```

```
















