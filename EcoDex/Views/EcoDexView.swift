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
            VStack(spacing: 0) {
                CustomNavTitle()
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.leading, 121)
                    .padding(.top, 8)
                Spacer()
                Divider()
                Spacer()
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ForEach(0..<220) { _ in
                            PlantCell(plant: mockPlant[0])
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationTitle("EcoDex")
    }
}


struct EcoDexView_Previews: PreviewProvider {
    static var previews: some View {
        EcoDexView()
    }
}
