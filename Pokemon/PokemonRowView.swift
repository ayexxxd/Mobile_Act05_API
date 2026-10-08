//
//  PlaceRowView.swift
//  Places
//
//  Created by Alex  on 10/07/26.
//

import SwiftUI

struct PokemonRowView: View {
    var pokemon : Pokemon
    var body: some View {
        VStack(spacing: 4){
            AsyncImage(url: pokemon.imageURL) { image in
                image
                    .resizable()
                    .interpolation(.none) // keeps the pixel sprites sharp
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width:80, height:80)
            Text("#\(pokemon.number)")
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            Text(pokemon.name.capitalized)
                .font(.subheadline)
                .fontWeight(.medium)
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
    PokemonRowView(pokemon: Pokemon (name: "placeholder",
                               url:"https://pokeapi.co/api/v2/pokemon/26/"))
}
