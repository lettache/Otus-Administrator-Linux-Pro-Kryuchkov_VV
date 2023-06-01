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























































