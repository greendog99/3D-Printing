OctoPrint Information
=====================

Serial Connection:
* Serial Port: `/dev/ttyUSB0`
* Baudrate: `250000`

Plugins
-------

A list of plugins I have installed, and some of their settings.

PortLister
* Notices when printers get turned on and tells the list of ports to
  refresh.

Firmware Updater
* Install avrdude with `sudo apt install avrdude`
* Flash method: `avrdude (Atmel AVR Family)`
* AVR MCU: `ATmega2560`
* Path to avrdude: `/usr/bin/avrdude`
* AVR Programmer Type: `wiring`

PrintTimeGenius
* More accurate print time estimates

Navbar Temperature
* Displays temperatures in the top navigation bar.

DisplayLayerProgress
* Displays more detailed layer progress in various places.
* Ensure PrusaSlicer's `Printer Settings` -> `Custom G-code` -> `Before
  layer change` box contains `;LAYER:[layer_num]`
* Enable "Show current height in Statusbar"
* Enable "Show layer information in Statusbar"
* Enable "Navigationbar" and enter: `[progress]% • Layer [current_layer]/[total_layers] • [current_height]/[total_height] mm • Fan [fanspeed] • `
* Set "Total height method" to `Max Z-Value with Extrusion`

Pushover
* Pushes notifications to Pushover app on mobile device.

