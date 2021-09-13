IMAGE_NAME := vim-env

.PHONY: build
build:
	docker build -t ${IMAGE_NAME} ./

.PHONY: shell
shell:
	docker run --rm -it ${IMAGE_NAME} bash

.PHONY: vim
vim:
	docker run --rm -it ${IMAGE_NAME} vim

.PHONY: clean
clean:
	docker rmi ${IMAGE_NAME}
