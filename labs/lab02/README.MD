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

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/08f72eac-5edc-459e-8510-de3290dc2e5f)

```
sudo fdisk -l
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/f4fcf67a-bc92-4b83-9abf-7ef6b1f64779)

```
sudo mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/36437e8a-18b3-4d0f-b7d3-13404dcee16c)

```
sudo mdadm --create --verbose /dev/md0 -l 6 -n 5 /dev/sd{b,c,d,e,f}
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d5187007-566b-4c1c-abe9-c4c0ee85f7db)

```
cat /proc/mdstat
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/2919094c-88a8-45ff-8ef8-23d83b52ac9a)

```
sudo mdadm -D /dev/md0
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/dd478ef5-b72d-46fa-9276-b34823dc66a7)

**Создание конфигурационного файла mdadm.conf

```
sudo mdadm --detail --scan --verbose
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/a76c0ff9-23b3-4082-9199-d1ba37f8e2bb)











