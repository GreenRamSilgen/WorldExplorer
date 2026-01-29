//
//  CountryDetailView.swift
//  WorldExplorer
//
//  Created by Kiran Shrestha on 1/29/26.
//

import SwiftUI

struct CountryDetailView: View {
    var country : RestOfWorld.Country
    var body: some View {
        VStack{
            Text(country.name.official)
                .font(.title)
                .fontWeight(.bold)
            Divider()
            VStack(alignment: .leading) {
                HStack{
                    Text("Region:")
                        .fontWeight(.bold)
                    Text(country.region)
                }
                HStack{
                    Text("Capital:")
                        .fontWeight(.bold)
                    Text(country.capital?.first ?? "No Capital")
                }
                VStack(alignment: .leading) {
                    Text("Flag:")
                        .fontWeight(.bold)
                    HStack{
                        Spacer()
                        AsyncImage(url: URL(string: country.flags.png)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                            }
                            else if (phase.error != nil) {
                                Image(systemName: "exclamationmark.triangle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                            }
                            else {
                                ProgressView()
                                    .scaleEffect(3)
                            }
                        }
                        Spacer()
                    }
                }
                if country.coatOfArms.png != nil {
                    VStack(alignment: .leading) {
                        Text("Coat of Arms:")
                            .fontWeight(.bold)
                        HStack{
                            Spacer()
                            AsyncImage(url: URL(string: country.coatOfArms.png!)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                }
                                else if (phase.error != nil) {
                                    Image(systemName: "exclamationmark.triangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                }
                                else {
                                    ProgressView()
                                        .scaleEffect(3)
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .font(.title2)
    }
}

#Preview {
    NavigationStack{
        CountryDetailView(country: .init(name: .init(common: "Test", official: "Offical Test THAT IS TOO LONG TO FIT"), region: "Asia", flag: "🇳🇵", capital: ["Cepital"], flags: .init(png: "temp.png", svg: "temp.svg"), coatOfArms: .init(png: "coat.png", svg: "coat.svg")))
    }
}
