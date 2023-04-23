//
//  UserRowView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/22/23.
//

import SwiftUI

struct UserRowView: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: 48, height: 48)
                .foregroundColor(Color("TertiaryTheme"))
            VStack(alignment: .leading) {
                Text("username")
                    .font(.subheadline).bold()
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView()
    }
}
