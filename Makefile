.PHONY: build run copy exec init	stop clean rmi clean-all

IMAGE = gguf-image
CONTAINER = gguf-container
REPO = https://huggingface.co/tokyotech-llm/Llama-3-Swallow-70B-v0.1
MODEL = Llama-3-Swallow-70B-v0.1
CONVERT_FILE = convert_hf_to_gguf.py
OUT_TYPE = TYPE

#

build:
	docker build -t $(IMAGE) --build-arg REPO=$(REPO) --build-arg MODEL=$(MODEL) --build-arg CONVERT=$(CONVERT_FILE) --build-arg TYPE=$(OUT_TYPE) --quiet .

run:
	docker run -d --name $(CONTAINER) $(IMAGE)

copy:
	docker cp $(CONTAINER):/models/$(MODEL)-$(OUT_TYPE).gguf .

exec:
	docker exec -it $(CONTAINER) bash

init:
	@make --no-print-directory build
	@make --no-print-directory run
	@make --no-print-directory copy

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
