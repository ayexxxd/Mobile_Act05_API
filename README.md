# Mobile_Act05_API
Pokemon API Getter

This app works like a pokedex!
It retrieves all Pokemon in the generation 9 Dex, including their name, description, dex number and sprite.
https://pokeapi.co/api/v2/pokemon?limit=1025

## What the app does
A SwiftUI Pokédex for iOS. It downloads the National Pokédex (#1–#1025) from PokeAPI and shows each Pokémon as a card (sprite, number and name) in a grid of 3 per row. Tapping a card opens a detail screen with a large sprite, the Pokédex number, the name, the Pokédex description and a button that plays the Pokémon's cry.

If the list can't load, the app shows a readable message instead of crashing; "No connection. Please try again." when the device is offline, or the server's error code if the API request fails, with a **Try again** button.

## API
[PokeAPI](https://pokeapi.co/) – free, no API key needed

| Data | Endpoint |
|---|---|
| Pokémon list (GET) | [`https://pokeapi.co/api/v2/pokemon?limit=1025`](https://pokeapi.co/api/v2/pokemon?limit=1025) |
| Description (GET) | `https://pokeapi.co/api/v2/pokemon-species/{number}/` (e.g. [Pikachu](https://pokeapi.co/api/v2/pokemon-species/25/)) |
| Sprites | `https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/{number}.png` |
| Cries (MP3) | `https://play.pokemonshowdown.com/audio/cries/{species name}.mp3` – from [Pokémon Showdown](https://play.pokemonshowdown.com/), because PokeAPI's cries are OGG files, which iOS can't play |

## How to run
**Requirements**
- Mac with **Xcode 27.0** or later
- iOS deployment target: **iOS 27.0**
- Internet connection (all data comes from the API)

**Steps**
1. Clone the repo:
   ```bash
   git clone https://github.com/ayexxxd/Mobile_Act05_API.git
   ```
2. Open `Pokemon.xcodeproj` in Xcode (double-click it, or **File › Open…**).
3. At the top of Xcode, select the **Pokemon** scheme and an iPhone simulator (e.g. **iPhone 18 Pro**).
4. Press **Run** (⌘R). The Pokédex loads when the app opens.
5. Tap any Pokémon to open its detail screen, then tap **Play cry** to hear it.

**Running on a real iPhone:** in the project's **Signing & Capabilities** tab, pick your own Team, then choose your iPhone as the run destination.
