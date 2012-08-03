#!/bin/make
DIRS=partners

all: $(DIRS)

.PHONY: $(DIRS)

$(DIRS):
	make -C "$@"

clean: $(patsubst %,%-clean,$(DIRS))

.PHONY: $(patsubst %,%-clean,$(DIRS))

$(patsubst %,%-clean,$(DIRS)):
	make -C "$(patsubst %-clean,%,$@)" clean

