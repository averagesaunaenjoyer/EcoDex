//
//  RankingsView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/18/23.
//

import SwiftUI

struct RankingsView: View {
    @State var searchText = ""

    var body: some View {
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
                            radius: 6
                        )
                )
            }
        }
    }
}

struct RankingsView_Previews: PreviewProvider {
    static var previews: some View {
        RankingsView()
    }
}
