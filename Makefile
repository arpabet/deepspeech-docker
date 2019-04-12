#
#   Simple makefile for DeepSpeech
#
#   Alex Shvid
#
#

DS_VER := 0.4.1
IMAGE := deepspeech
VERSION := $(DS_VER)-$(shell git describe --tags --always --dirty)
REGISTRY := arpabet

all: build

version:
	@echo $(VERSION)

build:
	docker build -t $(REGISTRY)/$(IMAGE):$(VERSION) --build-arg DS_VER=$(DS_VER) -f Dockerfile .

run: build
	docker run -it $(REGISTRY)/$(IMAGE):$(VERSION) /bin/bash

push: build
	docker push ${REGISTRY}/${IMAGE}:${VERSION}
	docker tag ${REGISTRY}/${IMAGE}:${VERSION} ${REGISTRY}/${IMAGE}:latest
	docker push ${REGISTRY}/${IMAGE}:latest
