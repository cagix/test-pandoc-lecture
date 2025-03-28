
###############################################################################
## Setup (public)
###############################################################################


## Working directory and User
## In case this doesn't work, set the path manually (use absolute paths).
WORKDIR                ?= .
USRID                  ?= $(shell id -u)
GRPID                  ?= $(shell id -g)


## Pandoc
## (Defaults to docker. To use pandoc and TeX-Live directly, create an
## environment variable `PANDOC` pointing to the location of your
## pandoc installation.)
PANDOC                 ?= docker run --rm --volume "$(WORKDIR):/data" --workdir /data --user $(USRID):$(GRPID) pandoc/extra:latest-ubuntu


## Source files
## (Adjust to your needs.)
METADATA               ?= cb.yaml
GFM_OUTPUT_DIR         ?= _gfm





###############################################################################
## Internal setup (do not change)
###############################################################################


## Auxiliary files
## (Do not change!)
DATA                    = .pandoc
ROOT_DEPS               = make.deps


## Source and target files for gfm (to be filled via make.deps target)
GFM_MARKDOWN_TARGETS    =
GFM_IMAGE_TARGETS       =





###############################################################################
## Main targets (do not change)
###############################################################################


## Common options
OPTIONS                 = --data-dir=$(DATA)


## Build docker image ("pandoc-thesis") containing pandoc and TeX-Live
docker:
	docker pull pandoc/extra:latest-ubuntu


## Clean-up: Remove temporary (generated) files
clean:
	rm -rf $(ROOT_DEPS)

## Clean-up: Remove also generated gfm-markdown files
distclean: clean
	rm -rf $(GFM_OUTPUT_DIR)





###############################################################################
## Auxiliary targets (do not change)
###############################################################################


$(ROOT_DEPS): $(METADATA)
	$(PANDOC) $(OPTIONS)  -L makedeps.lua  -M prefix=$(GFM_OUTPUT_DIR)  -f markdown -t markdown  $<  -o $@

ifeq (gfm,$(MAKECMDGOALS))  ## this needs docker/pandoc, so do only include (and build) when required
-include $(ROOT_DEPS)
endif


## Enable secondary expansion for subsequent targets. This allows the use
## of automatic variables like '@' in the prerequisite definitions by
## expanding twice (e.g. $$(VAR)). For normal variable references (e.g.
## $(VAR)) the expansion behaviour is unchanged as the second expansion
## has no effect on an already fully expanded reference.

.SECONDEXPANSION:

.DEFAULT_GOAL:=help


## GFM: Process markdown with pandoc
gfm: OPTIONS           += --metadata-file=$(METADATA)
gfm: $(ROOT_DEPS) $$(GFM_MARKDOWN_TARGETS) $$(GFM_IMAGE_TARGETS)

$(GFM_MARKDOWN_TARGETS):
	$(create-folder)
	$(PANDOC) $(OPTIONS)  -d gfm.yaml  $<  -o $@

$(GFM_IMAGE_TARGETS):
	$(create-dir-and-copy)


## Canned recipe for creating output folder
define create-folder
@mkdir -p $(dir $@)
endef

## Canned recipe for creating output folder and copy output file
define create-dir-and-copy
$(create-folder)
cp $< $@
endef





###############################################################################
## Declaration of phony targets
###############################################################################


.PHONY: all docker gfm clean distclean
