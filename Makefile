# 
# Makefile for keycap generator
#
# Make options:
#
# make all		makes STL models for each type of keycap
# make gcode		makes the gcode for each type of keycap
# 
#
# Based on the version from Elena of Valhalla:
# www.trueelena.org/computers/howto/makefile_for_openscad_projects.html
#
BUILDDIR = build
SRCDIR = src

ifndef $(SLICER)
SLICER=slic3r
endif

ifndef $(PROFILE)
PROFILE=dsa
endif

.PHONY: all gcode clean

all: row1 row2 row3 row4 row5

#$(BUILDDIR)/$(PROFILE)-1u-r1.stl: $(SRCDIR)/key.scad

$(BUILDDIR)/dsa-1u-r1.stl: $(SRCDIR)/key.scad
	mkdir -p ${BUILDDIR}
	openscad -o $@ $<

clean:
	rm -f $(BUILDDIR)/*.stl $(BULDDIR)/*.gcode
	rmdir --ignore-fail-on-non-empty $(BUILDDIR)
