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

**Добавить в Vagrantfile еще дисков**

```
:sata5 => {
                        :dfile => './sata5.vdi',
                        :size => 250,
                        :port => 5
```

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

**Создание конфигурационного файла mdadm.conf**

```
sudo mdadm --detail --scan --verbose
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/a76c0ff9-23b3-4082-9199-d1ba37f8e2bb)


```
su
cd /etc/
mkdir mdadm
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf
```

**Сломать/починить RAID**

```
mdadm /dev/md0 --fail /dev/sde
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/38e1a6b1-15aa-4e3d-b277-e665500476f1)

```
cat /proc/mdstat
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/40e22677-0445-4c9e-aecf-5f19b689df3d)

```
mdadm -D /dev/md0
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/03738d7a-7a6c-4c0b-98a2-3e9322a93cb6)

```
mdadm /dev/md0 --remove /dev/sde
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/e18f00b9-a698-4620-92e4-af15386c83fe)

```
mdadm /dev/md0 --add /dev/sde
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/2fbace30-e2cd-415a-a12b-0bf166508a1a)

```
cat /proc/mdstat
mdadm -D /dev/md0
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/07cf29cf-681c-4cc6-bc63-4d07cf2566b1)

**Создать GPT раздел, пять партиций и смонтировать их на диск**

```
parted -s /dev/md0 mklabel gpt
```

```
parted /dev/md0 mkpart primary ext4 0% 20%
parted /dev/md0 mkpart primary ext4 20% 40%
parted /dev/md0 mkpart primary ext4 40% 60%
parted /dev/md0 mkpart primary ext4 60% 80%
parted /dev/md0 mkpart primary ext4 80% 100%
```

![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/b7d5866b-2d8c-4960-ae63-234eed5fabbb)

```
for i in $(seq 1 5); do sudo mkfs.ext4 /dev/md0p$i; done
mkdir -p /raid/part{1,2,3,4,5}
for i in $(seq 1 5); do mount /dev/md0p$i /raid/part$i; done
```


















