# Практика с SELinux.

**Задачи:**

* Запустить nginx на нестандартном порту 3-мя разными способами:
    * переключатели setsebool
    * добавление нестандартного порта в имеющийся тип
    * формирование и установка модуля SELinux
* К сдаче:
    * README с описанием каждого решения (скриншоты и демонстрация приветствуются)
* Обеспечить работоспособность приложения при включенном selinux. 
    * развернуть приложенный стенд https://github.com/mbfx/otus-linux-adm/tree/master/selinux_dns_problems
    * выяснить причину неработоспособности механизма обновления зоны (см. README)
    * предложить решение (или решения) для данной проблемы
    * выбрать одно из решений для реализации, предварительно обосновав выбор
    * реализовать выбранное решение и продемонстрировать его работоспособность

**Решение**

**Создаём виртуальную машину**

```
Vagrant init centos/7
vagrant up
vagrant ssh
sudo -i
```

**Запуск nginx на нестандартном порту 3-мя разными способами**

```
systemctl status firewalld
```

```
nginx -t
```

```
getenforce 
```

```
yum install policycoreutils-python
```

```
grep 4881 /var/log/audit/audit.log | audit2why
```

```
setsebool -P nis_enabled on
systemctl restart nginx
systemctl status nginx
```

```
getsebool -a | grep nis_enabled
```

```
setsebool -P nis_enabled off
```

**Разрешим в SELinux работу nginx на порту TCP 4881 c помощью добавления нестандартного порта в имеющийся тип:**

```
semanage port -l | grep http
```

```
semanage port -a -t http_port_t -p tcp 4881
semanage port -l | grep  http_port_t
```

```
systemctl restart nginx
systemctl status nginx
```

```
semanage port -d -t http_port_t -p tcp 4881
semanage port -l | grep  http_port_t
```

```
systemctl restart nginx
systemctl status nginx
```

**Разрешим в SELinux работу nginx на порту TCP 4881 c помощью формирования и установки модуля SELinux:**

```
semanage port -l | grep http
```

```
semanage port -a -t http_port_t -p tcp 4881
semanage port -l | grep  http_port_t
```

```
systemctl restart nginx
systemctl status nginx
```

```
semanage port -d -t http_port_t -p tcp 4881
semanage port -l | grep  http_port_t
```

```
systemctl restart nginx
systemctl status nginx
```

**Разрешим в SELinux работу nginx на порту TCP 4881 c помощью формирования и установки модуля SELinux:**

```
systemctl start nginx
```

```
grep nginx /var/log/audit/audit.log
```

```
grep nginx /var/log/audit/audit.log | audit2allow -M nginx
```

```
semodule -i nginx.pp
```

```
systemctl restart nginx
systemctl status nginx
```

```
semodule -l
```

```
semodule -r nginx
```

#

**Обеспечение работоспособности приложения при включенном SELinux**






















