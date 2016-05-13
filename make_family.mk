# This is a makefile for generating DCS keycaps
BUILDDIR=build
SCADDIR=src
C=openscad -D $$$$fn=4
P=~/bin/plater -W 200 -H 200
MKDIR=mkdir -p $(BUILDDIR)
KEY_DEPS=$(SCADDIR)/key.scad make_family.mk $(BUILDDIR)
FAMILY?=dcs

# Row profiles
ifeq ($(FAMILY),dcs)
PROFILE_R1=1
PROFILE_R2=2
PROFILE_R3=3
PROFILE_R4=4
PROFILE_R5=4
PROFILE_SPACE=10
endif
ifeq ($(FAMILY),sa)
PROFILE_R1=6
PROFILE_R2=7
PROFILE_R3=8
PROFILE_R4=9
PROFILE_R5=9
PROFILE_SPACE=8
endif

.PHONY: all row1 row2 row3 row4 row5 models plated

all: models

models: row1 row2 row3 row4 row5

plated: $(BUILDDIR)/$(FAMILY)_60.plated.stl

row1: $(BUILDDIR)/key-$(FAMILY)-r1-100u.stl $(BUILDDIR)/key-$(FAMILY)-r1-200u.stl

row2: $(BUILDDIR)/key-$(FAMILY)-r2-100u.stl $(BUILDDIR)/key-$(FAMILY)-r2-150u.stl

row3: $(BUILDDIR)/key-$(FAMILY)-r3-100u.stl $(BUILDDIR)/key-$(FAMILY)-r3-175u.stl $(BUILDDIR)/key-$(FAMILY)-r3-225u.stl

row4: $(BUILDDIR)/key-$(FAMILY)-r4-100u.stl $(BUILDDIR)/key-$(FAMILY)-r4-225u.stl $(BUILDDIR)/key-$(FAMILY)-r4-275u.stl

row5: $(BUILDDIR)/key-$(FAMILY)-r5-125u.stl $(BUILDDIR)/key-$(FAMILY)-r5-625u.stl

vertical: $(BUILDDIR)/key-$(FAMILY)-r2-200u-vertical.stl $(BUILDDIR)/key-$(FAMILY)-r4-200u-vertical.stl

$(BUILDDIR):
	$(MKDIR)
	
$(BUILDDIR)/key-$(FAMILY)-r1-100u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R1) -D key_length=1 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r1-200u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R1) -D key_length=2 $< -o $@
	
$(BUILDDIR)/key-$(FAMILY)-r2-100u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R2) -D key_length=1 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r2-150u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R2) -D key_length=1.5 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r2-200u-vertical.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R2) -D key_length=2 -D vertical=1 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r3-100u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R3) -D key_length=1 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r3-175u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R3) -D key_length=1.75 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r3-225u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R3) -D key_length=2.25 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r4-100u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R4) -D key_length=1 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r4-225u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R4) -D key_length=2.25 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r4-275u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R4) -D key_length=2.75 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r4-200u-vertical.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R4) -D key_length=2 -D vertical=1 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r5-125u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R5) -D key_length=1.25 $< -o $@

$(BUILDDIR)/key-$(FAMILY)-r5-625u.stl: $(KEY_DEPS)
	$C -D key_profile=$(PROFILE_R5) -D key_length=6.25 -D inverted_dish=1 -D stabilizers=1 -D stabilizer_distance=50 $< -o $@

$(BUILDDIR)/$(FAMILY)_60.plater:
	$(MKDIR)
	echo key-$(FAMILY)-r1-100u.stl 13 > $@
	echo key-$(FAMILY)-r1-200u.stl 1 >> $@
	echo key-$(FAMILY)-r2-100u.stl 12 >> $@
	echo key-$(FAMILY)-r2-150u.stl 2 >> $@
	echo key-$(FAMILY)-r3-100u.stl 11 >> $@
	echo key-$(FAMILY)-r3-175u.stl 1 >> $@
	echo key-$(FAMILY)-r3-225u.stl 1 >> $@
	echo key-$(FAMILY)-r4-100u.stl 10 >> $@
	echo key-$(FAMILY)-r4-225u.stl 1 >> $@
	echo key-$(FAMILY)-r4-275u.stl 1 >> $@
	echo key-$(FAMILY)-r5-125u.stl 7 >> $@
	echo key-$(FAMILY)-r5-625u.stl 1 >> $@

$(BUILDDIR)/%.plated.stl: $(BUILDDIR)/%.plater
	$P $< -o $@

clean:
	rm -f $(BUILDDIR)/*.plated.stl
	rm -f $(BUILDDIR)/key-*.stl
	rm -f $(BUILDDIR)/*.plater
