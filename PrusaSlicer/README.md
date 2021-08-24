PrusaSlicer
===========

My PrusaSlicer configuration and notes.

Latest software download is at https://github.com/prusa3d/PrusaSlicer/releases

Configuration
-------------

The included `PrusaSlicer_config_bundle.ini` can be imported via `File` ->
`Import` -> `Import config bundle`. This will add several Printer, Filament,
and Print presets. The new presets all start with `MDF_` (my initials) to
easily separate them from defaults and other customized presets.

This `config_bundle.ini` is for PrusaSlicer 2.2.0.

Tips & Tricks
-------------

* To disable gap fill entirely, set `Speed` -> `Gap fill` to `0`.

Filament Color Changes
----------------------

After slicing, the layer slider can be adjusted and the (+) button used to add
an `M600` _Filament Change_ command to the gcode at the start of the selected
layer.

`M600` will normally cause the Marlin firmware to stop printing and wait for
user acknowledgement via the touchscreen. However, there is no process to purge
the old color from the nozzle before resuming the print. Therefore, I use a
custom script to modify the gcode, searching for `M600` and replacing it with
more advanced commands.

The included `filament_change.py` script path will need to be installed on the
same computer as PrusaSlicer, and the path to the script added in `Print
Settings` -> `Output options` -> `Post-processing scripts`. The script will be
called when the `Export G-code` or `G>Send to Printer` buttons are pressed.

The `filament_change.py` script performs the following steps:

1. Searches for `M600` gcode commands.
1. Remembers the current Z position of the nozzle.
1. Retracts filament to prevent oozing onto the print.
1. Moves the nozzle up and away from the print.
1. Retracts the filament all the way to the extruder entry.
1. Pauses the job via `M0` to allow the user to swap filaments.
   _New filament should be inserted until it is just visible at the beginning of the bowden tube._
1. Waits for the `Resume` button in Octoprint to continue the job.
1. Moves to the front-left (home) of the print bed.
1. Inserts filament all the way to the nozzle.
1. Extrudes a thick wipe line to purge the nozzle of the prior color.
1. Returns to the previously stored Z position and continues the print.

Each purge line must be removed from the bed before the next filament change!
