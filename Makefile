MAKEFLAGS += --no-builtin-rules

INSTALL_PREFIX = ~/.hammerspoon/Spoons
LIB_PREFIX = /usr/local/share/lua/5.4
REMOTE = $(shell git remote)
REMOTE_URL = $(shell git remote get-url "${REMOTE}")
PUBLISH_DIR = ${PWD}/tmp/publish
BRANCH_NAME = release
SPOONS := $(wildcard *.spoon)
TARGET_SPOONS := $(patsubst %,${INSTALL_PREFIX}/%,${SPOONS})
TARGET_ZIPS := $(patsubst %,${PUBLISH_DIR}/Spoons/%.zip,${SPOONS})
LIBS = $(wildcard lib/*)
TARGET_LIBS = $(patsubst lib/%,${LIB_PREFIX}/%,${LIBS})

SOURCES = $(shell find *.spoon -name "*.lua" -type f)
SPOON_SOURCES = $(filter $(1)/%,${SOURCES})

.SUFFIXES:

install: ${TARGET_SPOONS} ${TARGET_LIBS}
libs: ${TARGET_LIBS}

${INSTALL_PREFIX}/%: %
	$(info linking $<...)
	@ln -sf ${PWD}/$< $@

${PUBLISH_DIR}:
	$(info creating publish directory...)
	@git clone -n -b "${BRANCH_NAME}" "${REMOTE_URL}" "${PUBLISH_DIR}" || { \
		mkdir -p "${PUBLISH_DIR}" \
		&& git -C "${PUBLISH_DIR}" init -b "${BRANCH_NAME}" \
		&& git -C "${PUBLISH_DIR}" remote add "${REMOTE}" "${REMOTE_URL}"; \
	}
	@mkdir -p "${PUBLISH_DIR}/Spoons"

release: ${TARGET_ZIPS}
	$(info adding files...)
	@git -C "${PUBLISH_DIR}" add .
	$(info committing...)
	@git -C "${PUBLISH_DIR}" commit -m "release" || true
	$(info pushing...)
	@git -C "${PUBLISH_DIR}" push --force "${REMOTE}" || true

${LIB_PREFIX}:
	@mkdir -p ${LIB_PREFIX}


${LIB_PREFIX}/%: lib/% ${LIB_PREFIX}
	$(info linking library $<...)
	@ln -sf ${PWD}/$< $@

.SECONDEXPANSION:
${PUBLISH_DIR}/Spoons/%.zip: $$(call SPOON_SOURCES,%)
	$(info creating $@...)
	@zip -r "$@" $^
