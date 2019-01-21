# morgulnet_microservices
## Домашнее задание kubernetes-1
Проходил туториал но были проблемы с доступом к ресурсам,
поменял регион чтобы начать

gcloud compute networks subnets create kubernetes \
  --network kubernetes-the-hard-way \
  --range 10.240.0.0/24 \
  --region europe-north1

for i in 0 1 2; do
  gcloud compute instances create controller-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --zone europe-north1-b \
    --private-network-ip 10.240.0.1${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,controller
done

for i in 0 1 2; do
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-1804-lts \
    --image-project ubuntu-os-cloud \
    --machine-type n1-standard-1 \
    --zone europe-north1-b \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags kubernetes-the-hard-way,worker
done

Меняем зону и регион
gcloud config set compute/zone europe-north1-b
gcloud config set compute/region europe-north1

созданы манифесты post-deployment.yml, ui-deployment.yml, comment-deployment.yml, mongo-deployment.yml

kubectl get pods
NAME                                  READY   STATUS    RESTARTS   AGE
busybox-bd8fb7cbd-nmkzq               1/1     Running   0          25m
comment-deployment-6b55676957-nqbl4   1/1     Running   0          39s
mongo-deployment-57cd8664c6-2h9gq     1/1     Running   0          58s
nginx-dbddb74b8-2dcf7                 1/1     Running   0          23m
post-deployment-5c65d8cd77-744tv      1/1     Running   0          48s
untrusted                             1/1     Running   0          11m

## Домашнее задание logging-1
 • Сбор неструктурированных логов
 • Визуализация логов
 • Сбор структурированных логов
 • Распределенная трасировка
 Код микросервисов обновлен, образы пересобраны с тегом логгинг
 Собран образ fluentd
 Изменен docker/docker-compose.yml
 Добавлен docker-compose-logging.yml

 Добавили сервис распределенного трейсинга Zipkin

## Домашнее задание monitoring-2
 Основное задание: 
 • Мониторинг Docker контейнеров
 • Визуализация метрик
 • Сбор метрик работы приложения и бизнес
 метрик
 • Настройка и проверка алертинга
 
 Установили и настроили cadvisor для мониторинга контейнеров
 Установили Grafanaб, подключили Prometheus как источник данных. Создали дашборды.
 Настроили alertmanager.

 Добавили информацию о новых образах в Makefile.

## Домашнее задание monitoring-1
Основное задание: запуск, конфигурация Prometheus; мониторинг состояния микросервисов; сбор метирк хоста с использованием экспортера
  Был установлен и сконфигурирован Prometheus
  Собрали свой образ Prometheus с конфигурацией мониторига наших микросервисов
  Описали запуск микросервисов и мониторинга в docker-compose.yml
  Изучили работу node-exporter

 Задание со *
  Добавили мониторинг микросервисов с помощью blackbox exporter
  ui (blackbox-http), post & comment (blackbox-tcp)
  
 Задание со * 
  Создали Makefile для сборки образов и пуша в докер хаб


## Домашнее задание Gitlab-ci-2
 Основные задания: расширить существующий пайплайн в gilab ci, определить окружения
 
 Задания со *: при пуше новой ветки должен создаваться сервер для окружения с возможностью удалить его кнопкой
  Исследованы разные возможности создания сервера для окружения
  Реализовано создание сервера с помощью утилиты gcloud
  удаление с кнопки on_stop: branch_stop_review
  
 Задания с **: в шаг build добавить сборку контейнера с приложением reddit, контейнер деплоить на созданный для ветки сервер
  В академических целях был создан gitlab-runner с ssh executor
  Образ приложения собираеться и запускаеться на созданном сервере

## Домашнее задание Gitlab-ci-1
 С использование packer запек новый образ с docker-compose.
 Создал инстанст с помощью terraform 
 Установил gitlab-ci 
 Задал пароль на root аккаунт
 Выключил регистраицю новых пользователей
 Создал проект
 Создал .gitlab-ci.yml, убежился что пайплайн отработал и тесты прошли успешно
 
 ** Задание со *
 Создал плейбук для создания gitlab-runner в докер контейнере и его регистрации
 https://devops-team-otus.slack.com/messages/CB8PFKJ2F/

## Домашнее задание Docker-4
 Разобрались с работой сети в Docker (none, hoxt, bridge)
 Разделили сети в нашем проекте на back и front
 UI (front) - POST,COMMENT (front,back) - DB (back)
 Установили Docker-compose, создали docker.compose.yml
 Добавили сети front и back.
 Параметризовали Порт публикации сервиса UI, версии сервисов, адресацию сетей,
 username (docker-hub) в .env файле.
 
 Имя проекта можно переопределить через переменную COMPOSE_PROJECT_NAME, а также аргументом при запуске -p

 Setting this is optional. If you do not set this, the COMPOSE_PROJECT_NAME defaults to the basename of the project directory
 -p, --project-name NAME     Specify an alternate project name (default: directory name)

 ** Задание со *
 Создал docker-compose.override.yml
 Реализован проброс папки с приложениями с докер хоста (reddit)
 Запуск puma с флагами --debug и -w 2

## Домашнее задание Docker-3
 Приложение разбито на микросервиси, в докер контейнерах

 ** Задание со *
 Создал docker.sh в котором реализованы следующие функции
 Запуск контейнеров с другими сетевыми алиасами
 Задаються переменные окружения (сетевые алиасы) не пересоздавая образа

 ** Задание со *
 Собрал образ на основе alpine linux (Для UI сервиса)
 m0rgulnet/ui               1.0                 2e80ddb7e7c5        About an hour ago     461MB
 m0rgulnet/ui               2.0                 9caccaeea0a1        10 seconds ago        194MB

## Домашнее задание Docker-2
 Создал новый проект docker
 Установил docker-machine и выдал доступ к проекту
 Установил reddit в докере
 Создал образ и запушил его на docker-hub
 Запустил свой образ с docker-hub

 ** Задание со *
 Реализовал поднятие инстансов с помощью Terraform
 Написал Ansible плейбуки для установки докера и запуска там приложения
 Создал шаблон пакера для образа с установленным docker

## Домашнее задание Docker-1
 Установлен docker 
 Проверена работа запуском docker run hello-world
 Познакомился с основными командами работы с докером
 
 ** Задание со *
 Сравнил выводы docker inspect для образа и контейнера, сделал выводы
