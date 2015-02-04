-include config.mk

IMAGES := $(patsubst %/Dockerfile,%,$(wildcard */Dockerfile))

$(patsubst %,%-image,$(IMAGES)): %-image: %/Dockerfile
	docker build --rm --tag cehoffman/$* $(dir $<)

$(patsubst %,%-start,$(IMAGES)): %-start: %/Dockerfile
	-docker stop $* 2> /dev/null && docker rm $* 2> /dev/null
	docker run --name $* --detach $($*_run_opts) cehoffman/$*

$(IMAGES): %: %-image %-start

.PHONY: $(IMAGES) $(patsubst %,%-image,$(IMAGES)) $(patsubst %,%-start,$(IMAGES))

shell:
	docker run --interactive --tty cehoffman/base /bin/bash

rm:
	docker ps -a | grep -E 'Exited \(-?[0-9]+\)' | awk '{ print $$1 }' | xargs -r docker rm

rmi:
	docker images | grep '^<none>' | awk '{print $$3}' | xargs -r docker rmi

clean: rm rmi

.PHONY: shell rm rmi clean

# Files that are not excluded by the main .gitignore but by a .gitignore in
# a subdirectory are considered private files
DIRS_WITH_PRIVATE_FILES=$(patsubst %/.gitignore,%,$(wildcard */.gitignore))
PRIVATE_FILES=$(foreach d,$(DIRS_WITH_PRIVATE_FILES),$(addprefix $(d),$(shell cat $(d)/.gitignore)))

pack:
	tar -c $(PRIVATE_FILES) | gzip -c9 | openssl aes-256-cbc -a -e -salt > private.dat

unpack:
	cat private.dat | openssl aes-256-cbc -a -d | tar -zx
	chmod 600 $(PRIVATE_FILES)

.PHONY: pack unpack
