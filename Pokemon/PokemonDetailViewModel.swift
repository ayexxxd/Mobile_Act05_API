//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Alex  on 10/07/26.
//

import Foundation
import Observation
//audio avfoundation is the apple framework that plays sound
import AVFoundation

//viewmodel for the detail screen, gets the description and plays the cry
//separate from pokemonviewmodel bc that one is only for the list, single responsibility
@MainActor @Observable

class PokemonDetailViewModel {
    var descriptionText = ""

    //audio link to the cry, it gets filled in when the species data loads
    var cryURL : URL?

    //audio the player is saved here bc if it was inside the function it gets deleted before the sound plays
    var player : AVPlayer?

    //get request to the pokemon species endpoint, same steps as getpokemon
    func getDescription(number: String) async throws {
        //save url
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(number)/")
            else {
            print("invalid url"); return}

        //url req
        let urlRequest = URLRequest(url: url)

        //url call
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { print("error"); return}

        let species = try JSONDecoder().decode(PokemonSpecies.self, from: data)

        //last english description bc its from the newest game, swap the line breaks for spaces
        let english = species.entries.last { $0.language.name == "en" }
        self.descriptionText = english?.text.replacingOccurrences(of: "\n", with: " ") ?? ""

        //audio the cry comes from pokemon showdown as an mp3 bc the pokeapi cries are ogg and iphones cant play ogg
        //audio showdown names the files after the pokemon without dashes, so mr mime becomes mrmime
        let fileName = species.name.replacingOccurrences(of: "-", with: "")
        self.cryURL = URL(string: "https://play.pokemonshowdown.com/audio/cries/\(fileName).mp3")
    }

    //audio plays the cry, avplayer streams it straight from the link
    func playCry() {
        guard let url = cryURL else { return }
        player = AVPlayer(url: url)
        player?.play()
    }
}
