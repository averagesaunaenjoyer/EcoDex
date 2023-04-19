//
//  PlantCell.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/18/23.
//

import SwiftUI

struct PlantCell: View {
    let plant: Plant
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(plant.name.capitalized)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.leading)
                Text(plant.scientific.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.top, 1)
                    .padding(.leading)
                HStack {
                    Text(plant.type)
                        .font(.subheadline).bold()
                        .foregroundColor(.mint.opacity(0.4))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0))
                        )
                        .frame(width: 100, height: 20)
                    
                    Image("Verbena")
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 75, height: 250)
                        .padding([.bottom, .trailing], 4)
                        .offset(x: 15, y: 0)
                }
            }
        }
        .background(.mint.opacity(0.4))
        .cornerRadius(12)
        .shadow(color: .mint, radius: 5, x: 0.0, y: 0.0)
    }
}

struct PlantCell_Previews: PreviewProvider {
    static var previews: some View {
        PlantCell(plant: mockPlant[0])
    }
}
