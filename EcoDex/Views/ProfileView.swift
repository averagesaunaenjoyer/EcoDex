//
//  ProfileView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/18/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("ThemeColor")
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    HStack {
                        Circle()
                            .frame(width: 90, height: 90)
                            .foregroundColor(Color("TertiaryTheme"))
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                    
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
