//
//  ContentView.swift
//  Places
//
//  Created by Alex on 07/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var pokemonVM = PokemonViewModel()
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(spacing: 12){
                    ForEach(pokemonVM.rows.indices, id: \.self) { index in
                        HStack(spacing: 12){
                            ForEach(pokemonVM.rows[index]) { pokemon in
                                NavigationLink{
                                    PokemonDetailView(pokemon: pokemon)
                                } label: {
                                    PokemonRowView(pokemon: pokemon)
                                }
                                .buttonStyle(.plain)
                                .frame(maxWidth: .infinity)
                            }
                            //empty spots so a short last row keeps the same card size
                            ForEach(0..<(3 - pokemonVM.rows[index].count), id: \.self) { _ in
                                Color.clear
                                    .frame()
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.red)
            .navigationTitle("Pokédex")
            .task{
                do{
                    try await pokemonVM.getPokemon()
                } catch{
                    print ("error calling the pokemon", error)}
            }
        }
    }
}

#Preview {
    ContentView()
}
