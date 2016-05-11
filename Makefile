.PHONY: all dcs
all: dcs
dcs:
	$(MAKE) --file=dcs_keycaps.mk all
clean:
	$(MAKE) --file=dcs_keycaps.mk clean

