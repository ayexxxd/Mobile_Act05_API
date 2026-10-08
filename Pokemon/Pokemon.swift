//
//  Pokemon.swift
//  Pokemon
//
//  Created by Alex  on 10/07/26.
//

import Foundation // swift fundamentals
import SwiftUI

//model only describes the data, no ui or networking here bc of single responsibility
//pokeapi wraps the list inside results, so this struct is just there to unwrap it
struct PokeAPIResponse : Decodable {
    var results : [Pokemon]
}

//one pokemon from the list, the api only gives name and url
struct Pokemon : Identifiable, Decodable{
    //id is made locally bc the list doesnt send one, identifiable needs it for foreach
    var id = UUID()
    var name : String
    var url : String

    //only decode name and url, id is left out so it keeps the uuid default
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    //pokedex number is the last part of the url, done here once so the views dont repeat it, dry
    var number : String {
        url.split(separator: "/").last.map(String.init) ?? ""
    }

    //sprite link built from the number bc the list endpoint doesnt include images
    var imageURL : URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(number).png")
    }
}

//from the pokemon species endpoint, only the parts we need for the description and the cry
struct PokemonSpecies : Decodable {
    var name : String
    var flavorTextEntries : [FlavorTextEntry]

    //cry mp3 from pokemon showdown bc the pokeapi cries are ogg and iphones cant play ogg
    //uses the species name bc showdown names the files that way, without symbols like mr mime becomes mrmime
    var cryURL : URL? {
        let fileName = name.filter { $0.isLetter || $0.isNumber }
        return URL(string: "https://play.pokemonshowdown.com/audio/cries/\(fileName).mp3")
    }
}

//one pokedex description, the api has one per game and per language
struct FlavorTextEntry : Decodable {
    var flavorText : String
    var language : Language
}

struct Language : Decodable {
    var name : String
}
