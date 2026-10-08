//
//  PlaceDetailView.swift
//  Places
//
//  Created by Alex  on 10/07/26.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemon : Pokemon
    var body: some View {
        VStack(spacing: 20){
            // sprite on top of a soft circle
            ZStack{
                Circle()
                    .fill(Color(.secondarySystemBackground))
                AsyncImage(url: pokemon.imageURL) { image in
                    image
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .padding(2)
            }
            .frame(width:340, height:340)

            VStack{
                Text("#\(pokemon.number)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()
            }

            Spacer()
        }
        .padding(.top, 32)
        .frame(maxWidth: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.red)
    }
}

#Preview {
    PokemonDetailView(pokemon : Pokemon (name:"pikachu",
                                  url: "https://pokeapi.co/api/v2/pokemon/25/"))
}
