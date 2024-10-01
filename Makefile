VERSION:=v0.0.$(shell date +%Y%m%d)
IMAGENAME:=httpserve
REGISTRY?=quay.io/fromani
BUILDID?=01
TAG?=$(VERSION)$(BUILDID)
IMAGE:=$(REGISTRY)/$(IMAGENAME):$(TAG)

.PHONY: all
all: build

.PHONY: build
build: binaries

image:
	@podman build -t $(IMAGE) .

binaries: httpserve

outdir:
	@mkdir -p _out

httpserve: outdir
	CGO_ENABLED=0 go build -v -o _out/httpserve main.go

.PHONY: vet
vet:
	go vet ./...

.PHONY: clean
clean:
	@rm -rf _out
