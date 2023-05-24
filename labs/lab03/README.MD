# Работа с LVM

**Задачи:**

  *1. Уменьшить том под / до 8G*
  
  *2. Выделить том под /home*

  *3. Выделить том под /var (/var - сделать в mirror)*
  
  *4. Для /home - сделать том для снэпшотов*
  
  *5. Прописать монтирование в fstab (попробовать с разными опциями и разными файловыми системами на выбор)*
  
  *6. Работа со снапшотами*
  
**Решение:**

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



















