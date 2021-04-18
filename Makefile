DOCKER_IMAGE = dind
TEMPLATE = 20.10-dind
IMAGE_TAG = noitran/docker:20.10-dind-latest

build:
	sed -e 's/%%DOCKER_IMAGE%%/$(DOCKER_IMAGE)/g' $(TEMPLATE)/Dockerfile.template > $(TEMPLATE)/Dockerfile
	docker build -f $(TEMPLATE)/Dockerfile . -t $(IMAGE_TAG)
	docker image ls | grep $(TEMPLATE)
.PHONY: build

test:
	export $IMAGE_TAG
	GOSS_FILES_PATH=$(TEMPLATE) dgoss run -t $(IMAGE_TAG)
.PHONY: test

clean:
	rm -rf */Dockerfile
.PHONY: clean

docker-push:
	docker push $(IMAGE_TAG)
.PHONY: docker-push
