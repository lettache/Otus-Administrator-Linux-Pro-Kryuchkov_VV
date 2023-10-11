# Резервное копирование

**Цель домашнего задания**

Научится делать резервное копирование

**Описание домашнего задания**

* Настроить стенд Vagrant с двумя виртуальными машинами: backup_server и client. (Студент самостоятельно настраивает Vagrant) Настроить удаленный бэкап каталога /etc c сервера client при помощи borgbackup. Резервные копии должны соответствовать следующим критериям:
    * директория для резервных копий /var/backup. Это должна быть отдельная точка монтирования. В данном случае для демонстрации размер не принципиален, достаточно будет и 2GB (Студент самостоятельно настраивает);
    * репозиторий для резервных копий должен быть зашифрован ключом или паролем - на ваше усмотрение;
    * имя бэкапа должно содержать информацию о времени снятия бекапа;
    * глубина бекапа должна быть год, хранить можно по последней копии на конец месяца, кроме последних трех. Последние три месяца должны содержать копии на каждый день. Т.е. должна быть правильно настроена политика удаления старых бэкапов;
    * резервная копия снимается каждые 5 минут. Такой частый запуск в целях демонстрации;
    * написан скрипт для снятия резервных копий. Скрипт запускается из соответствующей Cron джобы, либо systemd timer-а - на ваше усмотрение;
    * настроено логирование процесса бекапа. Для упрощения можно весь вывод перенаправлять в logger с соответствующим тегом. Если настроите не в syslog, то обязательна ротация логов.

**Решение**

**Запустим стенд Vagrant + Ansible**

```
vagrant up --no-provision
ANSIBLE_ARGS='--skip-tags="client"' vagrant provision
ANSIBLE_ARGS='--tags="client"' vagrant provision client
```

- оставим стенд поработать пол часа

- Смотрим лог на client

```bash
vagrant ssh client
sudo -i

cat /var/log/messages | grep borg
Oct 10 20:17:20 localhost borg: ------------------------------------------------------------------------------
Oct 10 20:17:20 localhost borg: Archive name: etc-2023-10-10_20:17:17
Oct 10 20:17:20 localhost borg: Archive fingerprint: f84b587d806995edb5770439249b753f14e2ac3f2f172db8982dd8fef64b92a1
Oct 10 20:17:20 localhost borg: Time (start): Thu, 2023-10-10 20:17:18
Oct 10 20:17:20 localhost borg: Time (end):   Thu, 2023-10-10 20:17:20
Oct 10 20:17:20 localhost borg: Duration: 1.79 seconds
Oct 10 20:17:20 localhost borg: Number of files: 1700
Oct 10 20:17:20 localhost borg: Utilization of max. archive size: 0%
Oct 10 20:17:20 localhost borg: ------------------------------------------------------------------------------
Oct 10 20:17:20 localhost borg: Original size      Compressed size    Deduplicated size
Oct 10 20:17:20 localhost borg: This archive:               28.43 MB             13.49 MB             28.84 MB
Oct 10 20:17:20 localhost borg: All archives:               28.43 MB             13.49 MB             28.84 MB
Oct 10 20:17:20 localhost borg: Unique chunks         Total chunks
Oct 10 20:17:20 localhost borg: Chunk index:                    1279                 1696
Oct 10 20:17:20 localhost borg: ------------------------------------------------------------------------------
Oct 10 20:22:47 localhost borg: ------------------------------------------------------------------------------
Oct 10 20:22:47 localhost borg: Archive name: etc-2023-10-10_20:22:46
Oct 10 20:22:47 localhost borg: Archive fingerprint: 3a81a3c4a1219c1486a841acfb732bfa3b77f72e0baf835fedd89f3bc4cd32d6
Oct 10 20:22:47 localhost borg: Time (start): Thu, 2023-10-10 20:22:47
Oct 10 20:22:47 localhost borg: Time (end):   Thu, 2023-10-10 20:22:47
Oct 10 20:22:47 localhost borg: Duration: 0.31 seconds
Oct 10 20:22:47 localhost borg: Number of files: 1700
Oct 10 20:22:47 localhost borg: Utilization of max. archive size: 0%
Oct 10 20:22:47 localhost borg: ------------------------------------------------------------------------------
Oct 10 20:22:47 localhost borg: Original size      Compressed size    Deduplicated size
Oct 10 20:22:47 localhost borg: This archive:               28.43 MB             13.49 MB            126.53 kB
Oct 10 20:22:47 localhost borg: All archives:               56.85 MB             26.99 MB             10.97 MB
Oct 10 20:22:47 localhost borg: Unique chunks         Total chunks
Oct 10 20:22:47 localhost borg: Chunk index:                    1017                 3396
Oct 10 20:22:47 localhost borg: ------------------------------------------------------------------------------
Oct 10 20:27:57 localhost borg: ------------------------------------------------------------------------------
Oct 10 20:27:57 localhost borg: Archive name: etc-2023-10-10_20:27:56
Oct 10 20:27:57 localhost borg: Archive fingerprint: 90a10548747e16dd8080493a6fabb1af3a5a099570693d70bad0169d9b56cb1f
Oct 10 20:27:57 localhost borg: Time (start): Thu, 2023-10-10 20:27:56
Oct 10 20:27:57 localhost borg: Time (end):   Thu, 2023-10-10 20:27:57
Oct 10 20:27:57 localhost borg: Duration: 0.10 seconds
Oct 10 20:27:57 localhost borg: Number of files: 1700
Oct 10 20:27:57 localhost borg: Utilization of max. archive size: 0%
Oct 10 20:27:57 localhost borg: ------------------------------------------------------------------------------
Oct 10 20:27:57 localhost borg: Original size      Compressed size    Deduplicated size
Oct 10 20:27:57 localhost borg: This archive:               28.43 MB             13.49 MB                717 B
Oct 10 20:27:57 localhost borg: All archives:               56.85 MB             26.99 MB             10.84 MB
Oct 10 20:27:57 localhost borg: Unique chunks         Total chunks
Oct 10 20:27:57 localhost borg: Chunk index:                    1014                 3400
Oct 10 20:27:57 localhost borg: ------------------------------------------------------------------------------
```

- последний созданный бекап

```bash
BORG_PASSPHRASE=Otus1234 borg list borg@192.168.50.11:/var/backup/
etc-2023-10-10_20:56:56              Thu, 2023-10-10 20:56:57 [fe48a53546ae1cbd053c4d45b00d0cdbeaf8d6180fb1c699adf35fa90e164134]
```

- смотрим список файлов

```bash
BORG_PASSPHRASE=Otus1234 borg list borg@192.168.50.11:/var/backup/::etc-2023-10-10_20:56:56 | head -n 10
drwxr-xr-x root   root          0 Thu, 2023-10-10 20:16:48 etc
-rw------- root   root          0 Thu, 2023-04-30 22:04:55 etc/crypttab
lrwxrwxrwx root   root         17 Thu, 2023-04-30 22:04:55 etc/mtab -> /proc/self/mounts
-rw-r--r-- root   root          7 Thu, 2023-10-10 20:13:17 etc/hostname
-rw-r--r-- root   root       2388 Thu, 2023-04-30 22:08:36 etc/libuser.conf
-rw-r--r-- root   root       2043 Thu, 2023-04-30 22:08:36 etc/login.defs
-rw-r--r-- root   root         37 Thu, 2023-04-30 22:08:36 etc/vconsole.conf
lrwxrwxrwx root   root         25 Thu, 2023-04-30 22:08:36 etc/localtime -> ../usr/share/zoneinfo/UTC
-rw-r--r-- root   root         19 Thu, 2023-04-30 22:08:36 etc/locale.conf
-rw-r--r-- root   root        450 Thu, 2023-10-10 20:13:21 etc/fstab
```

- остановим бекап

```bash
systemctl stop borg-backup.timer
```

- восстановим директорию /etc из бекапа

```bash
cd
BORG_PASSPHRASE=Otus1234 borg extract borg@192.168.50.11:/var/backup/::etc-2023-10-10_20:56:56 etc

rm -rf /etc/
ls /etc/ | wc -l
0

cp -Rf etc/* /etc/

ls /etc/ | wc -l
180
```












