# Fire Alarm & VGA-Based Display System

## Project Overview
A VHDL-based fire safety system that displays fire/flood alerts on VGA monitor and controls LED patterns via UART commands. Plus we can enter certain commands to see some outputs on the VGA monitor itself.


### Hardware Setup
- Connect **VGA cable** to monitor
- Connect **USB-UART cable** (CP2102) to computer
- Power on **DE10-Lite FPGA board**

### Software Setup
1. Open **Tera Term** → Serial → Baud Rate: **9600**
2. Load project in **Intel Quartus Prime**
3. Program the FPGA

## Available Commands
### Part 1
| Command | Action |
|---------|--------|
| `A` | Explosion LED Pattern |
| `B` | Alternating LED Pattern |
| `C` | Snake LED Pattern |
| `D` | Sparkle LED Pattern |
| `F` | VGA Fire Alert |
| `f` | VGA Flood Alert |

*Type command + ENTER to execute.*
Only the last typed character before Enter is considered. Previous command resets automatically.

### Part 2
| Command | Action |
|---------|--------|
| `prof` | Name of the EE232 instructor appears |
| `made` | Names of the engineers appear |
| `name` | Project name appears |


## 📁 Project Files
### Part 1
- `vga_text_display.vhd` - Main controller
- `vga_timing.vhd` - VGA display timing
- `uart_rx.vhd` - Serial communication
- `text_buffer.vhd` - Character memory
- `clk.vhd` - Clock management
- `ascii_orig.vhd` - stores pre-rendered ASCII character graphics

### Part 2
- `TOP.vhd` - Main controller
- `vga_timing.vhd` - VGA display timing
- `uart_rx.vhd` - Serial communication
- `text_buffer.vhd` - Character memory
- `fire.vhd`, `flood.vhd` - Alert images
- `fire_alarm.vhd` - LED animations
- `clk.vhd` - Clock management

---

## Team
**Group 7** - EE232 Course Project
