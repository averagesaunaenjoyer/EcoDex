//
//  NothingToSeeHereView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/23/23.
//

import SwiftUI

struct NothingToSeeHereView: View {
    var body: some View {
        ZStack {
            Color("ThemeColor")
                .ignoresSafeArea()
            VStack {
                Text("Nothing to see here...")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .shadow(
                                color: .gray.opacity(0.4),
                                radius: 0
                            )
                            .padding(.horizontal, 7)
                            .padding(.vertical, 7)
                    )
                Image(systemName: "arrowshape.turn.up.left.fill")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.white)
                    .shadow(
                        color: .gray.opacity(0.4),
                        radius: 0
                    )
                    .scaleEffect(1.3)
                    .offset(x: 39, y: -17)
                Image("EcoGuy2")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(30)
                    .blur(radius: 3)
            }
        }
    }
}

struct NothingToSeeHereView_Previews: PreviewProvider {
    static var previews: some View {
        NothingToSeeHereView()
    }
}
