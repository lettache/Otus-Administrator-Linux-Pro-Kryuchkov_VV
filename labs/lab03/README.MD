# Работа с LVM

**Задачи:**

  *1. Уменьшить том под / до 8G*
  
  *2. Выделить том под /home*

  *3. Выделить том под /var (/var - сделать в mirror)*
  
  *4. Для /home - сделать том для снэпшотов*
  
  *5. Прописать монтирование в fstab (попробовать с разными опциями и разными файловыми системами на выбор)*
  
  *6. Работа со снапшотами*
  
**Решение:**

**Введение в работу с LVM**

```
lsblk
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/12db0424-dfe2-4905-a057-12eb55d61240)

```
sudo lvmdiskscan
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/31cfc902-33ac-4a08-84e4-79320690216f)

```
pvcreate /dev/sdb
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/96f71cce-1e8f-429f-bdb4-395783912f92)

```
vgcreate otus /dev/sdb
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/7bbd42dc-1288-40ba-ae2f-592e23c88392)

```
lvcreate -l+80%FREE -n test otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/702c9b00-83f8-4c06-8a7a-bc2ce70cc9c3)

```
vgdisplay otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/88dcbbd1-0edb-48ac-9bee-d74f5fadeb24)

```
vgdisplay -v otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/9fec8c3f-e91a-4fe6-b9af-35b16378d3ec)

```
lvdisplay /dev/otus/test
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/1c680a3d-a07b-4f93-a2dd-b4ceed794eee)

```
vgs
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/5f857f15-60d2-4ce0-a896-468972078d49)

```
lvs
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/e39aa688-86c6-416c-bb14-61d2ad9a5cca)

```
lvcreate -L100M -n small otus
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/b623e30d-f792-4e81-bb69-f5c6b8c775ee)

```
lvs
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/afeefbc3-2887-4b52-aed2-ae6f44486267)

```
mkfs.ext4 /dev/otus/test
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/7a3c03b3-e099-4bf5-beda-d604285d5777)

```
mkdir /data 
mount /dev/otus/test /data/ 
mount | grep /data 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/622f9010-9f93-4185-bb62-a2f9cd5b0823)

**Расширение LVM**





















