//
//  PokemonRowView.swift
//  Pokemon
//
//  Created by Alex  on 10/07/26.
//

import SwiftUI

//view one pokemon card in the grid
//its own small view so contentview stays short and the card gets reused for every pokemon, clean code small views
struct PokemonRowView: View {
    var pokemon : Pokemon
    var body: some View {
        VStack(spacing: 4){
            //asyncimage bc the sprite comes from the internet, the spot stays empty until it loads
            AsyncImage(url: pokemon.imageURL) { image in
                image
                    .resizable()
                    .interpolation(.none) // keeps the pixel sprites sharp
                    .scaledToFit()
            } placeholder: {
                Color.clear
            }
            .frame(width:80, height:80)
            Text("#\(pokemon.number)")
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            Text(pokemon.name.capitalized)
                .font(.subheadline)
                .fontWeight(.medium)
                //long names shrink a bit instead of getting cut off
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 6)
        .frame(maxWidth: .infinity)
        .background(Color(.white), in: RoundedRectangle(cornerRadius: 16))
    }
}
#Preview {
    PokemonRowView(pokemon: Pokemon (name: "raichu",
                               url:"https://pokeapi.co/api/v2/pokemon/26/"))
}
