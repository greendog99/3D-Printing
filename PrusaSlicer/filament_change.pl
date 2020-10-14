#!/usr/bin/perl -i
#
# Gcode post-processing script for PrusaSlicer single extruder color change.
# by Michael Fischer
#
use strict;
use warnings;

my $g1z = '';     # used to remember the last "G1 Z" command encountered
my $g1e = '';     # used to remember the last extruder position ("G1 E")
my $g1xy = '';    # used to remember the last X & Y coordinates

my $height = 20;  # used to store the height to move up to before filament swap
my $wipe_y = 0;   # y location to use for next nozzle purge

# Read through the input Gcode line by line.
while (<>) {
  # Store any "G1 Z" commands seen. The last one before an M600 will
  # be used to return the print head to the correct Z coordinate after
  # the swap. The value is also used to move the nozzle up a bit before
  # the swap.
  #
  # Example: G1 Z0.650 F7800
  if (rindex($_, "G1 Z", 0) == 0) {
    $g1z = $_;
    ($height) = $g1z =~ qr/G1 Z([\d\.]+)/;
    $height += 20;
  }

  # Store any "G1 E" values seen. The last one before an M600 will
  # be used to return the extruder to the correct coordinate after
  # the filament swap and purge.
  #
  # Example: G1 X56.590 Y22.241 E724.47683
  if ($_ =~ /G1.+(E.+$)/) {
    $g1e = $1;
  }

  # Store any "G1 X## Y##" commands seen. The last one before an M600
  # will be used to return the hotend to the previous coordinate after
  # the filament swap.
  if ($_ =~ /G1.+(X[\d.]+ Y[\d.]+)/) {
    $g1xy = $1;
  }

  # If the line is M600, insert custom filament change code.
  if (rindex($_, "M600", 0) == 0) {
    my $trash = readline(<>);   # Throw away the next line (retract 3)
    $wipe_y += 5;            # Move the wipe (nozzle clean) line a bit further
    print ";\n; MDF Filament / color change\n;\n";
    print "G92 E0            ; Zero the extruded length\n";
    print "G1 E-20 F1200     ; Retract for easier filament swap\n";
    print "G0 Z$height          ; Move up a bit to prevent dragging across print\n";
    print "G0 X0 Y$wipe_y          ; Move close to front left\n";
    print "G1 E-40 F1200     ; Retract a bit more\n";
    print "M0                ; Pause for filament change until user presses 'Resume'\n";
    print "G0 Z0.15          ; Move back to layer 0 for wipe\n";
    print "G92 E0            ; Zero the extruded length (user pushed new filament in)\n";
    print "G1 X50 E30 F500   ; Extrude 30mm of filament in a 50mm line\n";
    print "G1 E27 F1000      ; Retract 3mm\n";
    print "G1 X90 F4000      ; Quickly wipe away from the filament line\n";
    print "G1 E25 F1000      ; Retract another 2mm (5mm total)\n";
    print "G0 Z$height          ; Move up again to prevent dragging across print\n";
    print "G0 $g1xy     ; Move back to previous X and Y position\n";
    print "; Move back to correct Z height.\n";
    print $g1z;
    print "G1 E29.9 F1000      ; Unretract\n";
    print "G92 $g1e       ; Restore extruder position\n";
  } else {
    print;    # Copy all other lines as-is
  }
}

exit 0;
