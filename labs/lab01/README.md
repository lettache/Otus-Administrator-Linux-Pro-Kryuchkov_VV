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



