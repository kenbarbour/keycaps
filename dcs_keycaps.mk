# This is a makefile for generating DCS keycaps
BUILDDIR=build
SCADDIR=src
C=openscad -D $$$$fn=4
P=~/bin/plater -W 200 -H 200

.PHONY: all row1 row2 row3

all: row1 row2 row3 row4 row5 plated

row1: $(SCADDIR)/key.scad
	$C -D key_profile=1 -D key_length=1 $< -o $(BUILDDIR)/key-dcs-r1-100u.stl
	$C -D key_profile=1 -D key_length=2 -D stabilizers=1 -D stabilizer_distance=12 $< -o $(BUILDDIR)/key-dcs-r1-200u.stl

row2: $(SCADDIR)/key.scad
	$C -D key_profile=2 -D key_length=1 $< -o $(BUILDDIR)/key-dcs-r2-100u.stl
	$C -D key_profile=2 -D key_length=1.5 $< -o $(BUILDDIR)/key-dcs-r2-150u.stl

row3: $(SCADDIR)/key.scad
	$C -D key_profile=3 -D key_length=1 $< -o $(BUILDDIR)/key-dcs-r3-100u.stl
	$C -D key_profile=3 -D key_length=1.75 $< -o $(BUILDDIR)/key-dcs-r3-175u.stl
	$C -D key_profile=3 -D key_length=2.25 -D stabilizers=1 -D stabilizer_distance=12 $< -o $(BUILDDIR)/key-dcs-r3-225u.stl

row4: $(SCADDIR)/key.scad
	$C -D key_profile=4 -D key_length=1 $< -o $(BUILDDIR)/key-dcs-r4-100u.stl
	$C -D key_profile=4 -D key_length=2.25 -D stabilizers=1 -D stabilizer_distance=12 $< -o $(BUILDDIR)/key-dcs-r4-225u.stl
	$C -D key_profile=4 -D key_length=2.75 -D stabilizers=1 -D stabilizer_distance=12 $< -o $(BUILDDIR)/key-dcs-r4-275u.stl

row5: $(SCADDIR)/key.scad
	$C -D key_profile=3 -D key_length=1.25 $< -o $(BUILDDIR)/key-dcs-r5-125u.stl
	$C -D key_profile=3 -D key_length=6.25 -D inverted_dish=1 -D stabilizers=1 -D stabilizer_distance=50 $< -o $(BUILDDIR)/key-dcs-r5-625u.stl

$(BUILDDIR)/dcs_fullset.plater:
	echo key-dcs-r1-100u.stl 13 > $@
	echo key-dcs-r1-200u.stl 1 >> $@
	echo key-dcs-r2-100u.stl 12 >> $@
	echo key-dcs-r2-150u.stl 2 >> $@
	echo key-dcs-r3-100u.stl 11 >> $@
	echo key-dcs-r3-175u.stl 1 >> $@
	echo key-dcs-r3-225u.stl 1 >> $@
	echo key-dcs-r4-100u.stl 10 >> $@
	echo key-dcs-r4-225u.stl 1 >> $@
	echo key-dcs-r4-275u.stl 1 >> $@
	echo key-dcs-r5-125u.stl 7 >> $@
	echo key-dcs-r5-625u.stl 1 >> $@

plated: $(BUILDDIR)/dcs_fullset.plater
	$P $< -o $(BUILDDIR)/dcs-plate_%03d

clean:
	rm -f $(BUILDDIR)/dcs-plate_*.stl
	rm -f $(BUILDDIR)/key-dcs-*.stl
	rm -f $(BUILDDIR)/dcs_*.plater
