//
//  ContentView.swift
//  Pokemon
//
//  Created by Alex on 10/07/26.
//

import SwiftUI

//view main list screen, only does layout, the data comes from pokemonviewmodel
struct ContentView: View {
    //state so the viewmodel stays alive while the view redraws
    @State private var pokemonVM = PokemonViewModel()
    var body: some View {
        //navigationstack so tapping a card can open the detail screen
        NavigationStack {
            ScrollView{
                VStack(spacing: 12){
                    //one hstack per row, 3 pokemon each, bc an hstack alone cant wrap to the next line
                    ForEach(pokemonVM.rows.indices, id: \.self) { index in
                        HStack(spacing: 12){
                            ForEach(pokemonVM.rows[index]) { pokemon in
                                //tap a card to open that pokemons detail view
                                NavigationLink{
                                    PokemonDetailView(pokemon: pokemon)
                                } label: {
                                    PokemonRowView(pokemon: pokemon)
                                }
                                //plain so the text doesnt turn blue like a link
                                .buttonStyle(.plain)
                                .frame(maxWidth: .infinity)
                            }
                            //empty spots so a short last row keeps the same card size
                            ForEach(0..<(3 - pokemonVM.rows[index].count), id: \.self) { _ in
                                Color.clear
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.red)
            .navigationTitle("Pokédex")
            //if the request failed, show the message from the viewmodel with a button to try again
            .overlay {
                if let message = pokemonVM.errorMessage {
                    VStack(spacing: 12){
                        Image(systemName: "wifi.exclamationmark")
                            .font(.largeTitle)
                        Text(message)
                            .multilineTextAlignment(.center)
                        Button("Try again") {
                            Task { await pokemonVM.getPokemon() }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                    .padding(24)
                    .background(Color.white, in: RoundedRectangle(cornerRadius: 16))
                    .padding()
                }
            }
            //task runs the api call when the screen shows up
            .task{
                await pokemonVM.getPokemon()
            }
        }
    }
}

#Preview {
    ContentView()
}
