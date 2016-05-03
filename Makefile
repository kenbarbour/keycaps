# 
# Makefile for keycap generator
#
# Make options:
#
# make all		makes STL models for each type of keycap
# make gcode		makes the gcode for each type of keycap
#
# Variables:
#  PROFILE 		Keycap profile to generate [dcs, dsa, sa]
#  SLICER		Slicing program to use for generating gcode
#
# Example usage:
# make PROFILE=dsa SLICER=slic3r gcode
#   Makes all the STL models for dsa profile keys and creates gcode using slic3r
# 
#
# Based on the version from Elena of Valhalla:
# www.trueelena.org/computers/howto/makefile_for_openscad_projects.htmli

## DIRECTORY CONFIG
BUILDDIR = build
SRCDIR = src

## DEFAULT SLICER
ifndef $(SLICER)
SLICER=slic3r
endif

# DEFAULT PROFILE
ifndef $(PROFILE)
PROFILE=dcs
endif

# Configure Rows
ifeq ($(PROFILE),dcs)
ROWS  =5 1 2 3 4
RP_MAP=0 1 2 3 4
else ifeq ($(PROFILE),dsa)
ROWS  =3
RP_MAP=5
else ifeq ($(PROFILE),sa)
ROWS  =1 2 3 4
RP_MAP=6 7 8 9
endif

ROW_TARGETS = $(patsubst %,$(PROFILE)-r%,$(ROWS))

.PHONY: all gcode clean

all:
	echo $(ROW_TARGETS)

#$(BUILDDIR)/$(PROFILE)-1u-r1.stl: $(SRCDIR)/key.scad

$(PROFILE): $(ROW_TARGETS)

$(PROFILE)-r%:
	echo $@

$(BUILDDIR)/$(PROFILE)-r%-%u.stl: $(SRCDIR)/key.scad
	mkdir -p ${BUILDDIR}
	openscad -D -o $@ $<

clean:
	rm -f $(BUILDDIR)/*.stl $(BULDDIR)/*.gcode
	rmdir --ignore-fail-on-non-empty $(BUILDDIR)
