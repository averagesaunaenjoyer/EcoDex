//
//  ExploreView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/22/23.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("ThemeColor")
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search by username...", text: $searchText)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .overlay(
                                Image(systemName: "xmark.circle.fill")
                                    .padding()
                                    .offset(x: 10)
                                    .foregroundColor(.gray)
                                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                                    .onTapGesture {
                                        searchText = ""
                                    }
                                ,alignment: .trailing
                            )
                    }
                    .font(.headline)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .shadow(
                                color: .gray.opacity(0.4),
                                radius: 5
                            )
                            .padding(.horizontal, 7)
                            .padding(.vertical, 7)
                    )
                    ScrollView {
                        LazyVStack {
                            ForEach(0...25, id: \.self) { _ in
                                NavigationLink {
                                    ProfileView(plant: mockPlant[0])
                                } label: {
                                    UserRowView()
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Explore")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
