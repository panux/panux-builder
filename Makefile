DIRS = builders

all: $(DIRS)

.PHONY: $(DIRS)

$(DIRS):
	$(MAKE) -C $@
