Mike's 3D Printing Notebook
===========================

My notes, configurations, upgrades, and links for printing with my
**Anycubic Mega-S** printer.

Firmware
--------

Firmware has been upgraded to Knutwurst's Marlin 2.0.x with custom Anycubic
adaptations:

* [Knutwurst's i3 MEGA Firmware based on Marlin 2.0.x](https://github.com/knutwurst/Marlin-2-0-x-Anycubic-i3-MEGA-S)

_Important:_ Marlin 2.0.x sends 12V to the part cooling fan instead of the
original 9V. The part cooling fan speed should be set to 75% in slicer settings
to compensate unless additional cooling is desired.

Slicing
-------

I almost exclusively use PrusaSlicer. Below is a link to my configurations and settings.

* [PrusaSlicer Config & Info](https://github.com/greendog99/3D-Printing/tree/master/PrusaSlicer)

Printer Upgrades
----------------

* [kuehmayer upgrade guide](https://www.thingiverse.com/thing:3409767)
* [renba upgrade guide](https://www.thingiverse.com/thing:2919245)
* [petrzmax upgrade guide](https://www.thingiverse.com/thing:2901190)

Things
------

[My Thingiverse Page:](https://www.thingiverse.com/greendog99)
* [Things I've designed](https://www.thingiverse.com/greendog99/designs)
* [Things I've printed](https://www.thingiverse.com/greendog99/makes)
* [My Collections](https://www.thingiverse.com/greendog99/collections)

Filament
--------

[Filament Experiences](https://github.com/greendog99/3D-Printing/blob/master/Filaments.md)

Lessons learned
---------------

* Temperatures
  * PLA: 185ºC tool and 60ºC bed
  * PLA+: 200ºC tool and 60ºC bed. At 185ºC PLA+ has trouble adhering to previous layers.
  * PLA with flecks, sparkles, etc: 210ºC tool and 60ºC bed. At lower temps, the nozzle may clog.
  * PETG: 235ºC tool and 90ºC bed for the first layer, then 225ºC & 80ºC to prevent stringing.

* Layer height
  * About 50% of nozzle diameter is ideal (e.g. 0.2mm with a 0.4mm nozzle).
    Can go up to 75% of nozzle size pretty safely, but layers may not adhere as well.

* Perimeter Width
  * Slicers generally use a default extrusion width of 1.125 × nozzle
    diameter (i.e. 0.45mm for a 0.4 mm nozzle).
  * Wider extrusion (through squishing the filament) will print faster. Widths up to
    around 1.5x nozzle diameter are safe (e.g. 0.6mm wide with a 0.4mm nozzle).
  * Slightly tweaking extrusion width can help eliminate thin gap-fill
    lines, e.g. when a wall is not an even multiple of nozzle width.

* Corners
  * Right angles require the print head to come to a complete stop when
    turning. This can cause filament to ooze, creating a bulge in the
    corner. Options:
    * Design with slightly rounded corners so the print head doesn't need to stop.
    * Print perimeters more slowly so the change in speed at corners is less drastic.
    * Use high acceleration/jerk values (in firmware and/or slicer) to
      reduce the time the print head spends in the corner. However this
      can cause other artifacts, such as ringing / ghosting since it
      causes backlash in the print head carriage.

* Elephant Foot
  * The first layer tends to expand slightly more than other layers,
    leading to a slight bulge at the bottom of the print. Setting
    Elephant Foot Compensation to 0.1mm or 0.2mm will shrink the first
    layer slightly to compensate for this.

