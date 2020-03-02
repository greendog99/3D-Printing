PrusaSlicer
===========

Latest version is available at https://github.com/prusa3d/PrusaSlicer/releases

The included `config_bundle.ini` can be imported from `File` -> `Import`
-> `Import config bundle`. This will add several Printer, Filament, and
Print configurations ending in "MDF" (my initials).

This `config_bundle.ini` is for PrusaSlicer 2.2.0-rc.

Filament Color Changes
----------------------

When slicing, the layer slider can be adjusted and the (+) button used
to add an `M600: Filament Change` command to the gcode at the start of
the selected layer.

`M600` will normally cause the Marlin 1.1.9 firmware to stop printing
and wait for user acknowledgement via the touchscreen. However, with
OctoPrint the touchscreen is not active and resuming the print from the
OctoPrint interface is non-trivial. Therefore, a custom script is used
to modify the gcode, searching for `M600` and replacing it with more
advanced commands.

The `config_bundle.ini` includes a call to an external Perl script used
to enhance mid-print filament color changes. The included
`filament_change.pl` script path will need to be installed on the same
computer as PrusaSlicer, and the path to the script updated in `Print
Settings` -> `Output options` -> `Post-processing scripts`. The script
will be called after slicing is complete, but before the gcode is sent
to OctoPrint.

The `filament_change.pl` script makes the following gcode changes:

1. Searches for `M600` gcode commands.
1. Remembers the current z-height of the nozzle.
1. Retracts filament slightly to let the filament end cool a bit.
1. Moves the hot end away from the print to prevent melting.
1. Pauses the job via `M0` to allow the user to swap filaments.
   _It is recommended that the user push the filament through the hot
   end until the new color is visible, then remove the extruded waste._
1. Waits for the `Resume` button in Octoprint to continue the job.
1. Moves to the front-left (home) of the print bend and extrudes a thick
   wipe line to purge the nozzle of the prior color.
1. Returns to the previously stored z-height to continue the print.

The script can handle many `M600` color changes in one print job, moving
slightly back each time for the next purge/wipe line:

![alt text](https://raw.githubusercontent.com/greendog99/3D-Printing/master/PrusaSlicer/wipe-lines.jpeg)
