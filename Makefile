APP_NAME := testapp
VERSION := latest
REGISTRY := quay.io/yournamespace

GOOS := $(shell go env GOOS)
GOARCH := $(shell go env GOARCH)
IMAGE_TAG := $(REGISTRY)/$(APP_NAME):$(VERSION)-$(GOOS)-$(GOARCH)

.PHONY: linux arm macos windows image clean

linux:
	docker build \
		--build-arg TARGETOS=linux \
		--build-arg TARGETARCH=amd64 \
		-t $(REGISTRY)/$(APP_NAME):$(VERSION)-linux-amd64 \
		.

arm:
	docker build \
		--build-arg TARGETOS=linux \
		--build-arg TARGETARCH=arm64 \
		-t $(REGISTRY)/$(APP_NAME):$(VERSION)-linux-arm64 \
		.

macos:
	docker build \
		--build-arg TARGETOS=darwin \
		--build-arg TARGETARCH=arm64 \
		-t $(REGISTRY)/$(APP_NAME):$(VERSION)-darwin-arm64 \
		.

windows:
	docker build \
		--build-arg TARGETOS=windows \
		--build-arg TARGETARCH=amd64 \
		-t $(REGISTRY)/$(APP_NAME):$(VERSION)-windows-amd64 \
		.

image:
	docker build \
		--build-arg TARGETOS=$(GOOS) \
		--build-arg TARGETARCH=$(GOARCH) \
		-t $(IMAGE_TAG) \
		.

clean:
	docker rmi $(IMAGE_TAG) || true
	docker rmi $(REGISTRY)/$(APP_NAME):$(VERSION)-linux-amd64 || true
	docker rmi $(REGISTRY)/$(APP_NAME):$(VERSION)-linux-arm64 || true
	docker rmi $(REGISTRY)/$(APP_NAME):$(VERSION)-darwin-arm64 || true
	docker rmi $(REGISTRY)/$(APP_NAME):$(VERSION)-windows-amd64 || true