# VGA-Based Display System

## Project Overview
We can enter certain commands to see some outputs on the VGA monitor itself. Also acts as a typewriter.


### Hardware Setup
- Connect **VGA cable** to monitor
- Connect **USB-UART cable** (CP2102) to computer
- Power on **DE10-Lite FPGA board**

### Software Setup
1. Open **Tera Term** → Serial → Baud Rate: **9600**
2. Load project in **Intel Quartus Prime**
3. Program the FPGA

## Available Commands

*Type command + ENTER to execute.*
Only the last typed character before Enter is considered. Previous command resets automatically.

| Command | Action |
|---------|--------|
| `prof` | Name of the EE232 instructor appears |
| `made` | Names of the engineers appear |
| `name` | Project name appears |


## 📁 Project Files
- `vga_text_display.vhd` - Main controller
- `vga_timing.vhd` - VGA display timing
- `uart_rx.vhd` - Serial communication
- `text_buffer.vhd` - Character memory
- `clk.vhd` - Clock management
- `ascii_orig.vhd` - stores pre-rendered ASCII character graphics


---

## Team
**Group 7** - EE232 Course Project
