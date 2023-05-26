# Стенд с Vagrant c ZFS

**Задачи:**

  *1. Определить алгоритм с наилучшим сжатием*
  
  *2. Определить настройки пула*

  *3. Работа со снапшотами*
  
**Решение:**

**Создаем виртуальную машину**

```
vagrant init centos/7
vagrant up
vagrant ssh
sudo -i
```

**Определение алгоритма с наилучшим сжатием**

```
lsblk
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/6eae1c5f-6801-4343-baca-8e0d250f7cff)

```
zpool create otus1 mirror /dev/sda /dev/sdb
zpool create otus2 mirror /dev/sdc /dev/sdd
zpool create otus3 mirror /dev/sde /dev/sdf
zpool create otus4 mirror /dev/sdg /dev/sdh
```

```
zpool list
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/6a9afea5-759b-41ea-920d-a03e4bdf1d7d)

```
zfs set compression=lzjb otus1
zfs set compression=lz4 otus2
zfs set compression=gzip-9 otus3
zfs set compression=zle otus4
```

```
zfs get all | grep compression
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/da50a679-71c4-4bde-bc61-50892011362f)

```
for i in {1..4}; do wget -P /otus$i https://gutenberg.org/cache/epub/2600/pg2600.converter.log; done
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/83a3d601-405f-4287-8d3c-8eb92a1cd639)

```
ls -l /otus*
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d88a1a7c-b4e9-4111-a5f8-d8419ffc7917)




































