//
//  EcoDexView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/18/23.
//

import SwiftUI

struct EcoDexView: View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                CustomNavTitle()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 8)
                Spacer()
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(0..<220) { _ in
                            PlantCell(plant: mockPlant[0])
                        }
                    }
                }
            }
            .background(Color("ThemeColor"))
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationTitle("EcoDex")
        .offset(x: 0, y: UIScreen.main.bounds.height / 10 - 95)
    }
}


struct EcoDexView_Previews: PreviewProvider {
    static var previews: some View {
        EcoDexView()
    }
}
