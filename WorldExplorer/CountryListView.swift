//
//  CountryListView.swift
//  WorldExplorer
//
//  Created by Kiran Shrestha on 1/29/26.
//

import SwiftUI
//https://restcountries.com/v3.1/region/europe
struct CountryListView: View {
    @State private var currentReion : RestOfWorld.Regions = .europe
    @State var world = RestOfWorld()
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Select Region")
                    Spacer()
                    Picker("Select region", selection: $currentReion) {
                        ForEach(RestOfWorld.Regions.allCases, id: \.self) { region in
                            Text(region.rawValue.capitalized)
                                .tag(region)
                        }
                    }
                    .onChange(of: currentReion, { oldValue, newValue in
                        Task{
                            await world.getData(of: currentReion)
                        }
                    })
                }
                .padding(.horizontal)
                List(world.countries) { country in
                    NavigationLink {
                        CountryDetailView(country: country)
                    } label: {
                        Text(country.name.common)
                            .font(.title)
                    }

                }
                .navigationTitle("Countries")
                .listStyle(.plain)
            }
            .task {
                await world.getData(of: currentReion)
            }
        }
        
    }
}

#Preview {
    CountryListView()
}
