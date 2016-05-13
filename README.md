3D-Printable Keycap Generator
=============================
This project is intended to generate some models and gcode for printing Cherry MX compatible keycaps

## Generating models
Use `make dcs-models` to generate dcs keycaps or `make sa-models` to generate sa keycaps
Plating and gcode generation is still a work in progress.

##Improvements
 * key.scad could automatically set stabilizer = 1 if key_length > 1.75 and stabilizer_spacing = 12 (50 if key_length > 6)

##License
This software is released under the GNU GPL v3 (http://www.gnu.org/licenses/gpl-3.0.en.html)
 with the exception of
 * src/key.scad (http://www.thingiverse.com/thing:468651): Attribution - Non-Commercial - Share Alike (http://creativecommons.org/licenses/by-nc-sa/3.0/)   Some small modifications were made.  See `git log src/key.scad` for details
