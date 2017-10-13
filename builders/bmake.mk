Dockerfile:
	cat $(BASES)/$(shell basename $(shell pwd))-$(ARCH) ../Dockerfile.in > Dockerfile

scripts:
	$(MAKE) -C ../scripts dump DESTDIR=$(shell pwd)

image: Dockerfile scripts
	docker build -t panux/builder:$(basename $(shell pwd))-$(ARCH) .
