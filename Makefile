INSTALL_PREFIX = ~/.hammerspoon/Spoons
LIB_PREFIX = /usr/local/share/lua/5.4
SPOONS := $(wildcard *.spoon)
TARGET_SPOONS := $(patsubst %,${INSTALL_PREFIX}/%,${SPOONS})
LIBS = $(wildcard lib/*)
TARGET_LIBS = $(patsubst lib/%,${LIB_PREFIX}/%,${LIBS})

install: ${TARGET_SPOONS} ${TARGET_LIBS}
libs: ${TARGET_LIBS}

${INSTALL_PREFIX}/%: %
	$(info linking $<...)
	@test -L $@ || rm -f $@
	@ln -sf $< $@


${LIB_PREFIX}:
	@mkdir -p ${LIB_PREFIX}


${LIB_PREFIX}/%: lib/% ${LIB_PREFIX}
	$(info linking library $<...)
	@ln -sf ${PWD}/$< $@
