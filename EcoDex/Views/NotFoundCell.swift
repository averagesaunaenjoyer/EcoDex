//
//  NotFoundCell.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/21/23.
//

import SwiftUI

struct NotFoundCell: View {
    let plant: Plant
    @Binding var isPresented: Bool
    
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
                        .foregroundColor(.mint.opacity(0))
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
                        .frame(width: 75, height: 125)
                        .padding([.bottom, .trailing], 2)
                        .offset(x: -50, y: -3)
                        .colorMultiply(.gray)
                }
            }
            .onTapGesture {
                isPresented = true
            }
        }
        .background(.gray.opacity(0.2))
        .saturation(0)
        .cornerRadius(12)
        .shadow(color: .gray, radius: 5, x: 0.0, y: 0.0)
    }
}

struct NotFoundCell_Previews: PreviewProvider {
    @State static var isPresented = false
    
    static var previews: some View {
        NotFoundCell(plant: mockPlant[0], isPresented: $isPresented)
    }
}
