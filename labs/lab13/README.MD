# Dockerfile

Создайте свой кастомный образ nginx на базе alpine. После запуска nginx должен 
отдавать кастомную страницу (достаточно изменить дефолтную страницу nginx).
Определите разницу между контейнером и образом.
Вывод опишите в домашнем задании.
Ответьте на вопрос: Можно ли в контейнере собрать ядро?
Собранный образ необходимо запушить в docker hub и дать ссылку на ваш
репозиторий.

**Docker**

* Команды которые могут понадобиться:
    * docker ps
    * docker ps -a
    * docker run -d -p port:port container_name
    * docker stop container_name
    * docker logs container_name - вывод логов контейнеров
    * docker inspect container_name - информация по запущенному контейнеру
    * docker build -t dockerhub_login/reponame:ver
    * docker push/pull
    * docker exec -it container_name bash

* Что должно быть Dockerfile:
    * FROM image name
    * RUN apt update -y && apt upgrade -y
    * COPY или ADD filename /path/in/image
    * EXPOSE portopenning
    * CMD or ENTRYPOINT or both

#не забываем про разницу между COPY и ADD
#or - одна из опций на выбор

**Задание со * (звездочкой)**

Создайте кастомные образы nginx и php, объедините их в docker-compose.
После запуска nginx должен показывать php info.
Все собранные образы должны быть в docker hub

