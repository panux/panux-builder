DIRS = preproc builders

all: $(DIRS)

.PHONY: $(DIRS)

$(DIRS):
	$(MAKE) -C $@
