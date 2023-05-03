# Vagrant-стенд для обновления ядра и создания образа системы

**Задачи:**

  *1. Обновить ядро ОС из репозитория ELRepo*
  
  *2. Создать Vagrant box c помощью Packer*

  *3. Загрузить Vagrant box в Vagrant Cloud*
  
   *Дополнительные задания:*
   - Ядро собрано из исходников
   - В образе нормально работают VirtualBox Shared Folders

**Решение:**

**1. Обновить ядро ОС из репозитория ELRepo**

```
vagrant init centos/stream8
```

![image](https://user-images.githubusercontent.com/84719218/235871994-75c6f7a5-8f4e-45a7-8ae6-27f6bc33fafb.png)

```
mcedit Vagrantfile
```
```
vagrant up
```


