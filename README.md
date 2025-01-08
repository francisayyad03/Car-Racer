# Traffic Racers

## Overview
**Traffic Racers** is a retro-style game developed using **MIPS Assembly**, where players control a car to avoid collisions with opposing cars. The game challenges the player to survive while earning points by avoiding obstacles.

---

## Features
- **Player Controls**: Navigate the car to dodge opposing vehicles.
- **Dynamic Gameplay**: Opponent cars have varying speeds and positions, making the game engaging and challenging.
- **Scoring System**: Track your score based on successful dodges.
- **Life Management**: Players have a limited number of lives; the game ends when all lives are lost.
- **Visual Feedback**: Uses color-coded elements to enhance the user experience.

---

## Code Structure
### **Data Segment**
- `pos`: Player's position.
- `enemyPos`: Positions of enemy cars.
- `speedE`: Speed of opposing cars.
- `lives`: Player's remaining lives.
- `score`: Current score.
- `color`: Color codes for game elements.

### **Text Segment**
- Contains the main game loop and subroutines for rendering, collision detection, and game logic.

---

## Requirements
- **MIPS Simulator**: Use simulators like [MARS](http://courses.missouristate.edu/KenVollmar/MARS/) or [SPIM](https://spimsimulator.sourceforge.net/).
- Basic understanding of MIPS Assembly to run or modify the game.

---
