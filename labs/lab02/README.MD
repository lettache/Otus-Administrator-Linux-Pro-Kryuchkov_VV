# Работа с mdadm

**Задачи:**

  *1. Добавить в Vagrantfile еще дисков*
  
  *2. Собрать R0/R5/R10 на выбор*

  *3. Прописать собранный рейд в конф, чтобы рейд собирался при загрузке*
  
  *4. Сломать/починить raid*
  
  *4. создать GPT раздел и 5 партиций и смонтировать их на диск*
  
   *Дополнительные задания:*
   - Vagrantfile, который сразу собирает систему с подключенным рейдом

**Решение:**

```
sudo lshw -short | grep disk
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/7a6c9030-5590-4afc-82e7-1306ea81f73c)

```
sudo fdisk -l
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/4bba2be1-79ce-4d62-b89f-0a4e8b5b4bd2)

```
sudo mdadm --zero-superblock --force /dev/sd{a,b,c,d,e,}
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/3455a6ac-2bf7-40cd-b7b6-fdf5efd23100)

```
mdadm --create --verbose /dev/md0 -l 6 -n 5 /dev/sd{b,c,d,e,f}
```

















