//
//  Place.swift
//  MyApp
//
//  Created by Alex  on 10/07/26.
//

import Foundation // swift fundamentals
import SwiftUI

struct PokeAPIResponse : Decodable {
    var results : [Pokemon]
}

struct Pokemon : Identifiable, Decodable{
    var id = UUID()
    var name : String
    var url : String

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }

    var number : String {
        url.split(separator: "/").last.map(String.init) ?? ""
    }

    var imageURL : URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(number).png")
    }
    
    var cryURL : URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/\(number).ogg")
    }
}
