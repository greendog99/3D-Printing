#!/usr/local/bin/python3 -E

# Gcode post-processing for PrusaSlicer single extruder color change.
#
# Assumptions:
#   - PrusaSlicer resets the extruder position to 0 at the end of each
#     layer (G92 E0).

import sys
import re
import os

filament_remove_length = 555
filament_insert_length = 538

sourceFile=sys.argv[1]

# Read the ENTIRE g-code file into memory
with open(sourceFile, "r") as f:
    lines = f.readlines()

with open(sourceFile, "w") as of:

    print('; Postprocessed by filament_change.py by Michael Fischer', end='\n\n', file=of)

    # Read through the input Gcode line by line.
    for line in lines:

        # Keep track of the most recent Z height and the line that called it.  The
        # last one before an M600 will be used to return the print head to the
        # correct Z coordinate after the swap. The value is also used to move the
        # nozzle up a bit before the swap.
        if match := re.search('^G1 Z([\d\.]+)', line, re.IGNORECASE):
            z = match.group(1)
            g1z = line

        # Replace any M600 commands with custom code to do a smarter filament swap.
        if (line.rstrip('\n') == 'M600'):
            print(';M600 filament change replacement gcode', file=of)
            print('M117 Please change filament and resume.', file=of)
            print('M83', file=of)                                # Relative mode for extruder positions
            print('G1 E-30 F900', file=of)                       # Retract filament slightly to prevent oozing
            print(f'G0 X0 Y5 Z{float(z) + 1} F900', file=of)     # Move the nozzle up a bit and to the corner
            print(f'G1 E-{filament_remove_length - 30} F900', file=of) # Retract filament the rest of the way
            print('M106 S80', file=of)                           # Slow down fan
            print('@pause', file=of)                             # Pause Octoprint for filament swap
            print('M106 S160', file=of)                          # Speed up fan
            print('G0 Z0.2', file=of)                            # Return to layer zero to perform a wipe
            print(f'G1 E{filament_insert_length} F900', file=of) # Insert filament back to the nozzle
            print('G1 X100 E60 F500', file=of)                   # Purge line to bring in new color
            print('G1 E-1 F1000', file=of)                       # Retract slightly to relieve pressure
            print('G1 X150 F1500', file=of)                      # Let nozzle ooze out
            print('M82', file=of)                                # Absolute mode for extruder positions
            print('G92 E0', file=of)                             # Zero out the extruder position
            print(g1z, file=of)                                  # Move the nozzle back to the correct height
            continue

        print(line, end='', file=of)

