//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Alex  on 10/07/26.
//

import Foundation
import Observation

//viewmodel gets the data and gets it ready, the views just read from here, single responsibility
//observable so the views update by themselves when arrpokemon changes
//mainactor bc the ui reads this, so updates have to happen on the main thread
@MainActor @Observable

class PokemonViewModel {
    var arrPokemon = [Pokemon]()
    //gets set when something fails so contentview can show it, nil means everything is fine
    var errorMessage : String?

    //get request to the pokeapi list, all 1025 national dex pokemon
    //async bc the download takes time and we dont want to freeze the app
    func getPokemon() async {
        errorMessage = nil

        //save url
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=1025")
            else {
            errorMessage = "Invalid URL."; return}

        //url req
        let urlRequest = URLRequest(url: url)

        //url call
        //every error gets caught here and turned into a message so the app never crashes
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            //only keep going if the server said 200, ok, otherwise show the code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            guard statusCode == 200 else {
                errorMessage = "The server returned an error, code \(statusCode). Please try again."; return}

            //turn the json into swift structs, pokeapiresponse bc the list is inside results
            self.arrPokemon = try JSONDecoder().decode(PokeAPIResponse.self, from: data).results
        } catch let error as URLError where error.code == .notConnectedToInternet || error.code == .networkConnectionLost {
            //offline check, these two codes mean theres no internet
            errorMessage = "No connection. Please try again."
        } catch {
            errorMessage = "Something went wrong loading the pokedex. Please try again."
        }
    }

    //splits the list into rows of 3 for the hstacks
    //its in the viewmodel and not the view bc its data prep, the view just draws the rows
    var rows: [[Pokemon]] {
        stride(from: 0, to: arrPokemon.count, by: 3).map { start in
            Array(arrPokemon[start..<min(start + 3, arrPokemon.count)])
        }
    }
}
