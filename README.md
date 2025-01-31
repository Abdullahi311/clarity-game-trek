# GameTrek
A blockchain-based adventure game built on Stacks using Clarity smart contracts.

## Overview
GameTrek is an on-chain adventure game where players can:
- Create and customize characters
- Battle monsters
- Level up and gain experience
- Collect items and equipment
- Trade items with other players

## Contracts
- `character.clar`: Handles character creation and attributes
- `battle.clar`: Contains battle mechanics and monster encounters with level requirements
- `inventory.clar`: Manages items and equipment
- `marketplace.clar`: Enables trading between players

## Game Mechanics
- Characters must meet minimum level requirements to battle specific monsters
- Monster information can be queried before engaging in battle
- Experience is awarded for successful monster battles

## Getting Started
1. Install Clarinet
2. Clone this repository
3. Run tests: `clarinet test`
4. Deploy contracts using Clarinet console
