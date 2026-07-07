# ZMK config — custom macropad / split half

User config repo for a custom PCB that works either as a standalone macropad
or as one half of a split keyboard. Layout supports a 2u key OR two 1u keys
in designated positions (handled as keymap/layout variants).

## Structure

```
config/
  west.yml            # pulls ZMK as a dependency
  vm35.keymap         # standalone macropad keymap (35 keys)
  vm35.conf           # standalone feature flags
  vm35_left.keymap    # split central, 70-key draft
  vm35_right.keymap   # split peripheral stub (unused bindings)
  vm35_{left,right}.conf
  boards/arm/vm35/    # custom board definition (nRF52840 / E73 module)
build.yaml            # build matrix: vm35, vm35_left, vm35_right
.github/workflows/    # CI that compiles firmware on every push
```

## Hardware (recovered from PCB files)

- MCU: nRF52840 on EByte E73-2G4M08S1C module (onboard 32.768 kHz crystal).
- Matrix: 7 rows × 5 cols, diodes **col2row**. Rows P0.28/30/31/29/02, P1.13, P0.03;
  cols P0.22/13/20/17/15. Joined to the switch motherboard by a 12-pin FPC.
- 2u keys: the six 2u positions are wired in parallel with a 1u position,
  so in firmware a 2u key is just its parent matrix position + a 2u cap.
- Split: two identical boards over BLE — left = central, right = peripheral.
- Bootloader: Adafruit nRF52 UF2 (S140 6.1.1), app at 0x26000. Drag-and-drop `.uf2`.
- Battery: divider on P0.04/AIN2; ext-power gate on P1.09.

## Status / to verify on hardware

- [x] Standalone macropad firmware (build-ready)
- [ ] Flash + confirm all 35 keys register (validates pin map)
- [ ] Confirm ext-power polarity (P1.09 assumed ACTIVE_LOW)
- [ ] Split: pair both halves, verify right-half positions (35–69)
- [ ] Finalize real keymaps (current ones are templates)

## Building

Push to GitHub — Actions compiles all targets and attaches `.uf2` files as
artifacts. Double-tap reset to enter the bootloader (NRF52BOOT drive appears),
then drag the matching `.uf2` onto it.
