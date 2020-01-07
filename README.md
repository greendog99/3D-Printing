Mike's 3D Printing Notebook
===========================

My notes, configurations, upgrades, and links for printing with my
**Anycubic Mega-S** printer.

Firmware
--------

Firmware has been upgraded to Marlin 1.1.9 with custom Anycubic
adaptations by derhopp and davidramiro.

* [Marlin 1.1.9 Anycubic GitHub Repo](https://github.com/davidramiro/Marlin-Ai3M) or [Thingiverse page with identical info](https://www.thingiverse.com/thing:3249319)
* [FAQ and calibration](https://github.com/davidramiro/Marlin-AI3M/wiki)
* I am using the `Marlin-AI3M-vx.x.x-TMC2208.hex` variant.

_Important:_ Marlin 1.1.9 sends 12V to part cooling fan instead of the
original 9V. Part cooling fan speed should be set to 75% in slicer
settings to compensate unless additional cooling is desired.

[Marlin gcode reference](http://marlinfw.org/meta/gcode/)

Printer Upgrades
----------------

* [kuehmayer upgrade guide](https://www.thingiverse.com/thing:3409767)
* [renba upgrade guide](https://www.thingiverse.com/thing:2919245)
* [petrzmax upgrade guide](https://www.thingiverse.com/thing:2901190)

Things
------

[My Thingiverse Page](https://www.thingiverse.com/greendog99)
* [Things I've created or modified](https://www.thingiverse.com/greendog99/designs)
* [Things I've printed](https://www.thingiverse.com/greendog99/makes)
* [My Collections](https://www.thingiverse.com/greendog99/collections)

Slicers
-------

[PrusaSlicer Config & Info](https://github.com/greendog99/3D-Printing/tree/master/PrusaSlicer)

[Cura Config & Info](https://github.com/greendog99/3D-Printing/tree/master/Cura)

Filament
--------

[Filament Experiences](https://github.com/greendog99/3D-Printing/blob/master/Filaments.md)

Lessons learned
---------------

* Temperatures
  * 185ºC works well for most PLA.
  * 200ºC works well for PLA+. At 185ºC PLA+ has trouble adhering to
    previous layers.
  * 225ºC works best for PETG.

* Layer height
  * About 50% of nozzle diameter is ideal. Can go up to 75% of
    nozzle size, but layers may not adhere as well (less "squish" when
    laying down layers) and may separate.

* Corners
  * Right angles require the print head to come to a complete stop when
    turning. This can cause filament to ooze, creating a bulge in the
    corner. Options:
    * Design with slight fillets (rounded corners) so the print head
      doesn't need to stop.
    * Print perimeters more slowly so the change in speed at corners
      is less drastic.
    * Use high acceleration/jerk values (in firmware and/or slicer) to
      reduce the time the print head spends in the corner. However this
      can cause other artifacts, such as ringing / ghosting since it
      causes backlash in the print head carriage.

* Elephant Foot
  * The first layer tends to expand slightly more than other layers,
    leading to a slight bulge at the bottom of the print. Setting
    Elephant Foot Compensation to 0.1mm will shrink the first layer slightly
    to compensate for this.
  * PrusaSlicer 2.2 (alpha) handles Elephant Foot edge cases much better than
    1.1.

* Extrusion Width
  * Slicers generally use a default extrusion width of 1.125 × nozzle
    diameter (i.e. 0.45mm for a 0.4 mm nozzle).
  * Wider extrusion (through squishing the filament) can provide better
    bed adhesion.
  * Slightly tweaking extrusion width can help eliminate thin gap-fill
    lines, e.g. when a wall is not an even multiple of nozzle width.

Designing in Fusion 360
=======================

TBD

