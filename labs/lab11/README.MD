# Автоматизация администрирования. Ansible.

**Задачи:**

* Необходимо использовать модуль yum/apt

* Конфигурационные файлы должны быть взяты из шаблона jinja2 с переменными

* После установки nginx должен быть в режиме enabled в systemd

* Должен быть использован notify длā старта nginx после установки

* Сайт должен слушать на нестандартном порту - 8080, для этого использовать переменные в Ansible

* Сделать все это с использованием Ansible роли

**Домашнее задание считается принятым, если:**

* Предоставлен Vagrantfile и готовый playbook/роль ( инструкция по запуску
стенда, если посчитаете необходимым )

* После запуска стенда nginx доступен на порту 8080

* При написании playbook/роли соблюдены перечисленные в задании условия


**Решение:**

```
ansible --version
```

```
vagrant ssh-config
```

```
cd etc/ansible/
vim hosts
```

```
ansible nginx - hosts -m ping
```

![Alt text](image-1.png)

```
vim ansible.cfg
```

```
vim hosts
```

```
ansible nginx -m ping
```

![Alt text](image-2.png)

```
ansible nginx -m command -a "uname -r"
```
![Alt text](image-3.png)

```
ansible nginx -m systemd -a name=firewalld
```
![Alt text](image-4.png)

```
ansible nginx -m yum -a "name=epel-release state=present" -b
```
![Alt text](image-5.png)

```
vim epel.yml
```

```
ansible-playbook epel.yml
```
![Alt text](image-6.png)

```
ansible nginx -m yum -a "name=epel-release state=absent" -b
```
```
ansible-playbook epel.yml
```
![Alt text](image-7.png)

```
vi NGINX.yml
```

```
ansible-playbook nginx.yml --list-tags
```
![Alt text](image-8.png)

```
ansible-playbook nginx.yml -t nginx-package
```

![Alt text](image-9.png)

```
vi nginx.yml
```

```
ansible-playbook nginx.yml
```
![Alt text](image-10.png)

```
curl http://192.168.11.150:8080
```
![Alt text](image-11.png)
