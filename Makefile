
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
SRC_DIR                ?= .
BIBFILE                ?= cb.bib
METADATA               ?= cb.yaml





###############################################################################
## Internal setup (do not change)
###############################################################################


## Auxiliary files
## (Do not change!)
DATA                    = .pandoc
GFM_OUTPUT_DIR          = _gfm
ROOT_DEPS               = make.deps
ROOT_DOC                = readme.md


## Source and target files for gfm (to be filled via make.deps target)
GFM_MARKDOWN_TARGETS =
GFM_IMAGE_TARGETS    =





###############################################################################
## Main targets (do not change)
###############################################################################


## Common options
OPTIONS                 = --bibliography=$(BIBFILE)
OPTIONS                += --metadata-file=$(METADATA)


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


$(ROOT_DEPS): $(ROOT_DOC)
	@$(PANDOC)  -L $(DATA)/makedeps.lua  -M prefix=$(GFM_OUTPUT_DIR)  -t markdown  $<  -o $@
-include $(ROOT_DEPS)


## Enable secondary expansion for subsequent targets. This allows the use
## of automatic variables like '@' in the prerequisite definitions by
## expanding twice (e.g. $$(VAR)). For normal variable references (e.g.
## $(VAR)) the expansion behaviour is unchanged as the second expansion
## has no effect on an already fully expanded reference.

.SECONDEXPANSION:

.DEFAULT_GOAL:=help


## GFM: Process markdown with pandoc
gfm: OPTIONS           += --defaults=$(DATA)/gfm.yaml
gfm: $$(GFM_MARKDOWN_TARGETS) $$(GFM_IMAGE_TARGETS)

$(GFM_MARKDOWN_TARGETS):
	$(create-folder)
	$(PANDOC) $(OPTIONS)  $<  -o $@

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
