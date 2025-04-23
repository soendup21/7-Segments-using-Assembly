# 7-Segment Display and LCD Control using Assembly

This project demonstrates the use of AVR microcontrollers to control a 7-segment display and an LCD. The code is written in Assembly language and includes examples of displaying numbers, patterns, and messages.

## Features

- **7-Segment Display Control**: Displays numbers and patterns using multiplexing.
- **Digital Clock Simulation**: Simulates a digital clock in HH:MM format.
- **LCD Control**: Displays messages on an LCD in 4-bit mode.

## Files

- `Assm.asm`: Demonstrates 7-segment display control with patterns and delays.
- `compile.asm`: Simulates a digital clock on a 4-digit 7-segment display.
- `Assembly.asm`: Demonstrates LCD control, including initialization and message display.

## How to Use

1. **Setup**: Ensure you have an AVR microcontroller and the necessary hardware (7-segment display, LCD, etc.).
2. **Assemble the Code**: Use an AVR assembler (e.g., AVR Studio or avra) to assemble the `.asm` files.
3. **Upload to Microcontroller**: Use a programmer to upload the assembled code to your AVR microcontroller.
4. **Run the Program**: Power the microcontroller and observe the output on the 7-segment display or LCD.

## Code Overview

### Assm.asm

- Initializes ports for 7-segment display control.
- Displays numbers and patterns with delays.

### compile.asm

- Simulates a digital clock in HH:MM format.
- Uses multiplexing to display time on a 4-digit 7-segment display.

### Assembly.asm

- Initializes an LCD in 4-bit mode.
- Displays messages and demonstrates basic LCD control.

## Requirements

- AVR microcontroller (e.g., ATmega32 or ATmega328P).
- 7-segment display and/or LCD.
- AVR assembler and programmer.

## License

This project is open-source and available for educational purposes. Feel free to modify and use it in your projects.
