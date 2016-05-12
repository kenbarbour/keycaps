.PHONY: all dcs
all: dcs
dcs:
	$(MAKE) --file=make_family.mk FAMILY=dcs all
dcs-models:
	$(MAKE) --file=make_family.mk FAMILY=dcs models
sa:
	$(MAKE) --file=make_family.mk FAMILY=sa all
sa-models:
	$(MAKE) --file=make_family.mk FAMILY=sa models
clean:
	$(MAKE) --file=dcs_keycaps.mk clean

