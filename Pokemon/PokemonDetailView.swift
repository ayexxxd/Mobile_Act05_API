//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Alex  on 10/07/26.
//

import SwiftUI

//view detail screen, opens when you tap a card in contentview
//gets the pokemon passed in, so it doesnt need to call the api again
struct PokemonDetailView: View {
    var pokemon : Pokemon
    //own viewmodel for the description and cry, state so it stays alive while the view redraws
    @State private var detailVM = PokemonDetailViewModel()
    var body: some View {
        VStack(spacing: 20){
            // sprite on top of a soft circle
            ZStack{
                Circle()
                    .fill(Color(.secondarySystemBackground))
                AsyncImage(url: pokemon.imageURL) { image in
                    image
                        .resizable()
                        .interpolation(.none) //no smoothing so the pixel art stays sharp when its big
                        .scaledToFit()
                } placeholder: {
                    Color.clear //empty until the image downloads
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

            //cry tap to hear the pokemon
            Button {
                detailVM.playCry()
            } label: {
                Label("Play cry", systemImage: "speaker.wave.2.fill")
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            .tint(.white)
            .foregroundStyle(.red)
            //greyed out until the species data loads bc thats where the cry link comes from
            .disabled(detailVM.cryURL == nil)

            //description error text if it failed, otherwise the pokedex text
            Group {
                if let error = detailVM.errorMessage {
                    Text(error)
                        .foregroundStyle(.secondary)
                } else {
                    Text(detailVM.descriptionText)
                }
            }
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)

            //pushes everything to the top of the screen
            Spacer()
        }
        .padding(.top, 32)
        .frame(maxWidth: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.red)
        //loads the description when the screen opens
        .task {
            await detailVM.getDescription(number: pokemon.number)
        }
    }
}

#Preview {
    PokemonDetailView(pokemon : Pokemon (name:"pikachu",
                                  url: "https://pokeapi.co/api/v2/pokemon/25/"))
}
