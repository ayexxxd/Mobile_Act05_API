//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Alex  on 10/07/26.
//

import Foundation
import Observation
import AVFoundation

//viewmodel for the detail screen, gets the description and plays the cry
//separate from pokemonviewmodel bc that one is only for the list, single responsibility
@MainActor @Observable

class PokemonDetailViewModel {
    var descriptionText = ""
    var errorMessage : String?
    //comes from the species data, stays empty until getdescription finishes
    var cryURL : URL?

    //the player has to be saved here, if it was a local var it gets deleted before the sound plays
    private var player : AVPlayer?

    //get request to the pokemon species endpoint for the pokedex description
    func getDescription(number: String) async {
        errorMessage = nil

        //save url
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(number)/")
            else {
            errorMessage = "Invalid URL."; return}

        //url req and url call
        //errors get caught here and turned into a message so the app doesnt crash
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                errorMessage = "Couldn't load the description."; return}

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let species = try decoder.decode(PokemonSpecies.self, from: data)
            cryURL = species.cryURL

            //last english entry bc its from the newest game, the old ones are all caps
            let entry = species.flavorTextEntries.last { $0.language.name == "en" }
            //the api text has random line breaks from the old game screens, so swap them for spaces
            descriptionText = entry?.flavorText
                .replacingOccurrences(of: "\n", with: " ")
                .replacingOccurrences(of: "\u{0C}", with: " ")
                ?? "No description available."
        } catch {
            errorMessage = "Couldn't load the description. Check your connection."
        }
    }

    //plays the cry straight from the link, avplayer bc it can stream it without downloading first
    func playCry() {
        guard let url = cryURL else { return }
        //playback so it still plays when the iphone is on silent
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        player = AVPlayer(url: url)
        player?.play()
    }
}
