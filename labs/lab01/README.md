# Vagrant-стенд для обновления ядра и создания образа системы

**Задачи:**

  *1. Обновить ядро ОС из репозитория ELRepo*
  
  *2. Создать Vagrant box c помощью Packer*

  *3. Загрузить Vagrant box в Vagrant Cloud*
  
   *Дополнительные задания:*
   - Ядро собрано из исходников
   - В образе нормально работают VirtualBox Shared Folders

**Решение:**

**Обновление ядра**

```
vagrant init generic/centos8s
```

![image](https://user-images.githubusercontent.com/84719218/235869904-7950010d-f5da-4464-80fd-0117909eb496.png)

