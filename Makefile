USER_NAME ?= m0rgulnet

build: ui_build post_build comment_build prometheus_build
push: ui_push post_push comment_push prometheus_push 
all: build push

.PHONY: build push all \
all build push up down\
ui_build ui_push ui \
post_build post_push post \
comment_build comment_push comment \
prometheus prometheus_build prometheus_push \

ui_build: 
	cd src/ui && ./docker_build.sh

post_build:
	cd src/post-py && ./docker_build.sh

comment_build:
	cd src/comment && ./docker_build.sh

prometheus_build:
	cd monitoring/prometheus && docker build -t $(USER_NAME)/prometheus . 

ui_push:
	docker push $(USER_NAME)/ui
comment_push:
	docker push $(USER_NAME)/comment
post_push:
	docker push $(USER_NAME)/post
prometheus_push:
	docker push $(USER_NAME)/prometheus
