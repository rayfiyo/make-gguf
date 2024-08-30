.PHONY: build run exec init start	stop clean rmi clean-all

CONTAINER = gguf-container
IMAGE = gguf-image

#

build:
	docker build -t $(IMAGE) --quiet .

run:
	docker run -d -p 11434:11434 --name $(CONTAINER) $(IMAGE)

exec:
	docker exec -it $(CONTAINER) bash

init:
	@make --no-print-directory build
	@make --no-print-directory run
	@make --no-print-directory exec

start:
	@make --no-print-directory run
	@make --no-print-directory exec

#

stop:
	docker stop $(CONTAINER)

clean:
	@make --no-print-directory stop
	docker rm $(CONTAINER)

rmi:
	docker rmi $(IMAGE)

clean-all:
	@make --no-print-directory clean
	@make --no-print-directory rmi
