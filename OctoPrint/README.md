OctoPrint Information
=====================

Serial Connection:
* Serial Port: `/dev/ttyUSB0`
* Baudrate: `250000`

Plugins
-------

Plugins I have installed, and some of their settings.

BetterHeaterTimeout
* Timeout: 600 seconds after target temp changes
* Bed: 3600 seconds

Consolidate Temp Control
* Combines the temperature and control tabs into one tab.
* Set Layout to "Vertical".

DisplayLayerProgress
* Displays more detailed layer progress in various places.
* Ensure PrusaSlicer's `Printer Settings` -> `Custom G-code` -> `Before
  layer change` box contains `;LAYER:[layer_num]`
* Enable "Show current height in Statusbar"
* Enable "Show layer information in Statusbar"
* Enable "Navigationbar" and enter: `[progress]% • Layer [current_layer]/[total_layers] • [current_height]/[total_height] mm • Fan [fanspeed] • `
* Set "Total height method" to `Max Z-Value with Extrusion`

Firmware Updater
* Install avrdude with `sudo apt install avrdude`
* Flash method: `avrdude (Atmel AVR Family)`
* AVR MCU: `ATmega2560`
* Path to avrdude: `/usr/bin/avrdude`
* AVR Programmer Type: `wiring`

MQTT
* Clean Session
* Base Topic: `octoPrint/`
* All events
* All progress messages
* Activate temperature messages (0.1º C)

_Navbar Temperature_
* Displays temperatures in the top navigation bar.

PortLister
* Automatically connects to printer when USB connection is detected.
* Set "Autoconnect delay" to `20`.

PrintTimeGenius
* More accurate print time estimates

PrusaSlicer Thumbnails
* Show thumbnail in state panel
* Use inline thumbnail

Pushover
* Pushes notifications to Pushover app on mobile device.
* Sound: Pushover Echo (long)
* Events: Print Done

Themeify
* Theme: Discoranged

TimeToFilament
* Adds "time until filament swap" to PrintTimeGenius.
* Add new Regex block, searching for `^M0`
