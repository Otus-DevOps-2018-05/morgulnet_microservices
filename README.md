# morgulnet_microservices
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
