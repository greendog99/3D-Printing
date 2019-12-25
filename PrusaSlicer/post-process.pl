#!/usr/bin/perl -i
#
# Gcode post-processing script for PrusaSlicer single extruder color change.
# by Michael Fischer
#
use strict;
use warnings;

my $g1z = '';     # used to store each "G1 Z" command encountered
my $height = 10;  # z height to move to befor filament swap
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

  # If the line is M600, insert custom filament change code.
  if (rindex($_, "M600", 0) == 0) {
    $wipe_y += 3;            # Move the wipe (nozzle clean) line a bit further
    print "G92 E0            ; Zero the extruded length\n";
    print "G1 E-25 F1200     ; Retract for easier filament swap\n";
    print "G0 Z$height       ; Move up a bit\n";
    print "G0 X0 Y$wipe_y    ; Move close to front left\n";
    print "M0                ; Pause for filament change until user presses 'Resume'\n";
    print "G0 Z0.15          ; Move back to layer 0 for wipe\n";
    print "G92 E0            ; Zero the extruded length\n";
    print "G1 X40 E25 F500   ; Extrude 25mm of filament in a 40mm line\n";
    print "G92 E0            ; Zero the extruded length\n";
    print "G1 E-5 F1000      ; Retract 5mm\n";
    print "G1 X80 F4000      ; Quickly wipe away from the filament line\n";
    print "G92 E0            ; Zero extruder - Prusa restarts at each layer\n";
    print $g1z;              # Move back to correct Z height.
  } else {
    print;    # Copy all other lines as-is
  }
}

exit 0;
