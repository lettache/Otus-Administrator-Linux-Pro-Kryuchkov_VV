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

```
zfs list
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/1a19c679-9829-4220-8e34-2fb3b7c5ffb0)

```
zfs get all | grep compressratio | grep -v ref
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d9f75219-d2ef-4a5d-97b0-e7d355588f39)

**Определение настроек пула**

```
wget -O archive.tar.gz --no-check-certificate "https://drive.google.com/u/0/uc?id=1KRBNW33QWqbvbVHa3hLJivOAt60yukkg&export=download&confirm=yes"
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/40090f28-1e4b-4c86-8d51-83fd9a9496cb)

```
tar -xzvf archive.tar.gz
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/0625b534-e009-484f-90a6-ab0fb15be7e3)

```
zpool import -d zpoolexport/
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/59c00772-2222-4cb6-b733-5bc7a17a43b4)

```
zpool import -d zpoolexport/ otus
zpool status
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/81c6d361-e001-4d93-b18f-0896145201a5)

```
zpool get all otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/e28cf853-bc03-4868-a3df-c79f2fcff52c)

```
zfs get available otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/6fdd3b70-0d83-42ca-9eb9-76979a4d2fa2)

```
zfs get readonly otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/c73aca1f-1e8a-4876-bd8d-9817ce2419e5)

```
zfs get recordsize otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/f86b8109-a140-4b9b-aa59-3292c8dc2a5e)

```
zfs get compression otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/cf4f3347-c342-4ce8-9c74-18e207163cad)

```
zfs get checksum otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/5a67055b-c138-4d1d-a095-b9a1a38068c8)

**Работа со снапшотом, поиск сообщения от преподавателя**












