//
//  PlceViewModel.swift
//  Places
//
//  Created by Alex  on 10/07/26.
//

import Foundation
import Observation

@MainActor @Observable

class PokemonViewModel {
    var arrPokemon = [Pokemon]()

    func getPokemon() async throws {
        //SAVE URL
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1025")
            else {
            print("invalid url"); return}

        //URL REQ
        let urlRequest = URLRequest(url: url)

        //URL CALL
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { print("error"); return}

        self.arrPokemon = try JSONDecoder().decode(PokeAPIResponse.self, from: data).results
    }

    //splits the list into rows of 3 for the HStacks
    var rows: [[Pokemon]] {
        stride(from: 0, to: arrPokemon.count, by: 3).map { start in
            Array(arrPokemon[start..<min(start + 3, arrPokemon.count)])
        }
    }
}
