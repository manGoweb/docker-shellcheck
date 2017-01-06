_: build

IMAGE := shellcheck

build:
	docker build -t ${IMAGE} .

tag:
	docker tag ${IMAGE}:latest mangoweb/${IMAGE}:latest
push:
	docker push mangoweb/${IMAGE}:latest


.PHONY: build tag push
