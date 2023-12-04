SHELL := /usr/bin/env TZ=UTC bash

export DOCKER_BUILDKIT=1
export IMG_VERSION=$(shell ./scripts/get-vers)
export IMG_NAME=$(shell cat IMG_NAME)
export DOCKER_REPO := ghcr.io
export DOCKER_IMAGE=$(DOCKER_REPO)/$(IMG_NAME):$(shell echo $(IMG_VERSION) |sed 's/\+/-/g')

all: image

image:
	@./scripts/build-img

show-image:
	@docker image ls $(DOCKER_IMAGE)

# these targets are declared "phony" so that make won't skip them if a file named after the target exists
.PHONY: all image
