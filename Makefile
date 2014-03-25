-include config.mk

IMAGES := $(patsubst %/Dockerfile,%,$(wildcard */Dockerfile))

$(patsubst %,%-image,$(IMAGES)): %-image: %/Dockerfile
	docker build --rm -t cehoffman/$* $(dir $<)

$(patsubst %,%-start,$(IMAGES)): %-start: %/Dockerfile
	-docker stop $* 2> /dev/null && docker rm $* 2> /dev/null
	docker run --name $* -d $($*_run_opts) cehoffman/$*

.PHONY: $(patsubst %,%-image,$(IMAGES)) $(patsubst %,%-start,$(IMAGES))

shell:
	docker run -i -t cehoffman/base /bin/bash

rm:
	docker ps -a | grep -E 'Exit -?[0-9]+' | awk '{ print $$1 }' | xargs -r docker rm

rmi:
	docker images | grep '^<none>' | awk '{print $$3}' | xargs -r docker rmi

clean: rm rmi

.PHONY: shell rm rmi clean
