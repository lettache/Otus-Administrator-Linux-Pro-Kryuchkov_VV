# Инициализация системы. Systemd.

**Задачи:**

  *1. Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова. Файл и слово должны задаваться в /etc/sysconfig*
     
**Решение:**

```
vagrant init centos/7
vagrant up
vagrant ssh
su
```
```
vi /etc/sysconfig/watchlog
```
```
cat /etc/sysconfig/watchlog
```
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/a57826bd-af24-4205-8d5c-107a46701d6f)
```
vi /var/log/watchlog.log
```
**Создадим скрипт:**
```
vi /opt/watchlog.sh
```
```
cat /opt/watchlog.sh
```
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/9d1d0b29-641b-48e5-903c-8ca515ec31b1)
```
chmod +x /opt/watchlog.sh
```
```
cd etc/systemd/system/
vi watchlog.service
vi watchlog.timer
```
```
systemctl start watchlog.timer
tail -f /var/log/messages
```
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/01d636c3-72cc-49d1-9f6d-2c10f427ae6e)

**Из epel установить spawn-fcgi и переписать init-скрипт на unit-файл. Имя сервиса должно также называться**
```
yum install epel-release -y && yum install spawn-fcgi php php-cli mod_fcgid httpd -y
```
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/1678e6a2-2871-4f9a-a34d-46d6053d480f)
```
vi /etc/sysconfig/spawn-fcgi
vi /etc/systemd/system/spawn-fcgi.service
```
```
systemctl start spawn-fcgi
systemctl status spawn-fcgi
```
![image](https://github.com/lettache/Otus-Administrator-Linux-Pro-Kryuchkov_VV/assets/84719218/184408d7-c677-4e4d-91f8-892ab470fb64)













































