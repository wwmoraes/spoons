INSTALL_PREFIX = ~/.hammerspoon/Spoons
SPOONS := $(wildcard *.spoon)
TARGET_SPOONS := $(patsubst %,${INSTALL_PREFIX}/%,${SPOONS})

install: ${TARGET_SPOONS}

${INSTALL_PREFIX}/%: %
	$(info linking $<...)
	@test -L $@ || rm -f $@
	@ln -sf $< $@
