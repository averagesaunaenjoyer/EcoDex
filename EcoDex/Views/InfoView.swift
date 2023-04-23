//
//  InfoView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/22/23.
//

import SwiftUI

struct InfoView: View {
    let plantInfo: PlantInfo
    
    var body: some View {
        ZStack {
            Color("TertiaryTheme")
                .ignoresSafeArea()
            VStack {
                ScrollView(.vertical) {
                    ScrollView(.horizontal) {
                        Spacer()
                        VStack {
                            Text(plantInfo.commonName)
                                .font(.title).bold()
                                .foregroundColor(.white)
                        }
                        HStack {
                            Image(systemName: "leaf.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(" #\(plantInfo.id)")
                                .font(.title)
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, -10)
                        VStack (alignment: .leading, spacing: 15) {
                            HStack (alignment: .top) {
                                Text("Common Name: ")
                                    .bold()
                                Text(plantInfo.commonName)
                            }
                            .foregroundColor(.white)
                            HStack (alignment: .top) {
                                Text("Scientific Name: ")
                                    .bold()
                                Text(plantInfo.scientificName)
                                    .italic()
                            }
                            .foregroundColor(.white)
                            HStack (alignment: .top) {
                                Text("Type: ")
                                    .bold()
                                Text(plantInfo.plantType)
                            }
                            .foregroundColor(.white)
                            HStack (alignment: .top) {
                                Text("Flower Color: ")
                                    .bold()
                                Text(plantInfo.flowerColor)
                            }
                            .foregroundColor(.white)
                            HStack (alignment: .top) {
                                Text("Height: ")
                                    .bold()
                                Text(plantInfo.height)
                            }
                            .foregroundColor(.white)
                        }
                        .font((.subheadline))
                        .frame(width: 350, height: 200)
                        .padding()
                        Spacer()
                    }
                }
                .fixedSize(horizontal: true, vertical: true)
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(plantInfo: mockPlantInfo[0])
    }
}
