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

            //audio button that plays the cry, it calls playcry in the viewmodel
            Button {
                detailVM.playCry()
            } label: {
                Label("Play cry", systemImage: "speaker.wave.2.fill")
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            .tint(.white)
            .foregroundStyle(.red)

            //pokedex description from the viewmodel
            Text(detailVM.descriptionText)
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
        //loads the description and the cry link when the screen opens, same do catch as contentview
        .task{
            do{
                try await detailVM.getDescription(number: pokemon.number)
            } catch{
                print ("error calling the description", error)}
        }
    }
}

#Preview {
    PokemonDetailView(pokemon : Pokemon (name:"pikachu",
                                  url: "https://pokeapi.co/api/v2/pokemon/25/"))
}
