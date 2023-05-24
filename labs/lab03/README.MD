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

```
pvcreate /dev/sdc
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/6e1c98d4-84c2-4394-89fa-b36f752ffb64)

```
vgextend otus /dev/sdc
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/77324ac7-361a-4feb-aea5-5337f95a3b85)

```
vgdisplay -v otus | grep 'PV Name'
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/8d856bd1-1507-4e8c-b8d5-2efdd61acc7b)

```
vgs
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/16a5df65-e810-4ecb-97b0-e42bd437fda2)

```
dd if=/dev/zero of=/data/test.log bs=1M count=8000 status=progress 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/f9eb8c93-7069-42d3-aef3-56c773c0fd3f)

```
df -Th /data/ 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/2cdd7486-ed8b-488c-87da-362f91953023)

```
lvextend -l+80%FREE /dev/otus/test 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/cb97a197-9f5a-4630-8b50-a2567c8379f9)

```
lvs /dev/otus/test
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/9f60b780-6259-4178-bcbd-720c99e2c6f0)

```
df -Th /data
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/65b5441a-adeb-4c12-bf5d-26e49f5f5617)

```
resize2fs /dev/otus/test
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/f12fa45b-16b5-4c90-923d-c1954827317d)

```
df -Th /data
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/de280433-3cbc-4449-b11f-c22ec9bcf3f9)

**Уменьшение LV**

```
umount /data/ 
e2fsck -fy /dev/otus/test 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/b6f85cf3-d14e-49dd-a806-a18a91e8c498)

```
resize2fs /dev/otus/test 10G
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/2bfad293-3633-4d59-80da-d8b53fd485ec)

```
lvreduce /dev/otus/test -L 10G
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/8c995284-52f2-4eae-8b8d-3a99f820d5f2)

```
mount /dev/otus/test /data/
df -Th /data/ 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/bfed6e5f-c193-49a3-abfc-6caa86085c90)

```
lvs /dev/otus/test
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/9a934b7a-2d52-4db0-bc8d-f522d314793a)

**LVM Snapshot**

```
lvcreate -L 500M -s -n test-snap /dev/otus/test 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d324d021-bb5a-4ada-9704-b0a08523c4e5)

```
vgs -o +lv_size,lv_name | grep test 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/8365c609-c936-4a7c-8676-e694c07e024e)

```
lsblk
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/1b065fb2-1017-4a2b-816e-1665aa7b1814)

```
mkdir /data-snap 
mount /dev/otus/test-snap /data-snap/ 
ll /data-snap/ 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d207270c-4976-447b-9af8-7cebdd1e5637)

```
umount /data-snap 
```

```
cd ~
rm test.log
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/9a95a253-afb2-4270-88a5-2d1f5a79ecce)

```
ll
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/3bb1bef9-2f98-4aa3-b0b6-e3c4fa21ce42)

```
umount /data 
lvconvert --merge /dev/otus/test-snap 
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/59a83d5d-f0a3-4d44-a3d1-b2f379077dc3)

```
mount /dev/otus/test /data
ll /data
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/5208f369-36ea-42d4-8ef2-b5103943b565)

```
pvcreate /dev/sd{d,e}
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/0c607749-f51e-43d6-abf5-2bf1b4c95c07)

```
vgcreate vg0 /dev/sd{d,e}
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/d01f62d3-de82-4f26-b0f5-3973f3c1b866)

```
lvcreate -l+80%FREE -m1 -n mirror vg0
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/468b020b-7285-4921-a0c0-e1ce67905870)

```
lvs
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/61136a50-ec02-4505-a5a3-5aeb86e6e28f)

**Домашнее задание**

```
pvcreate /dev/sdb
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/5262abb7-5d4b-484b-b8a0-e3c83cd69466)

```
vgcreate vg_root /dev/sdb
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/aa99e8e8-e0ca-4e97-8244-240858b54c7b)

```
lvcreate -n lv_root -l +100%FREE /dev/vg_root
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/07b1ef3c-ed5e-43f4-9fbc-4f218ecf9127)

```
mkfs.xfs /dev/vg_root/lv_root 
mount /dev/vg_root/lv_root /mnt
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/564dc034-d49e-49c4-8522-4866d5babca9)

```
xfsdump -J - /dev/VolGroup00/LogVol00 | xfsrestore -J - /mnt
```







