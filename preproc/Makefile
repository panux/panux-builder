all: image

godep:
	go get -u github.com/panux/package-builder

preproc: godep
	(sh genv-$(ARCH).sh go build -o preproc -v preproc.go)

Dockerfile:
	cat $(BASES)/alpine-$(ARCH) Dockerfile.in > Dockerfile

image: Dockerfile preproc
	docker build -t panux/preproc:$(ARCH) .
