//
//  NoInfoView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/23/23.
//

import SwiftUI

struct NoInfoView: View {
    var body: some View {
        ZStack {
            Color(.systemGray2)
                .ignoresSafeArea()
            VStack (alignment: .center, spacing: 5) {
                Spacer()
                Spacer()
                Spacer()
                Text("???")
                    .font(Font.system(size: 75))
                Text("Oops, you haven't")
                    .font(Font.system(size: 40))
                Text("found this plant yet!")
                    .font(Font.system(size: 40))
                Spacer()
                Text("Capture this plant to access its data.")
                    .font(Font.system(size: 20))
                Group {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
            .bold()
            .foregroundColor(.white)
            .padding(.horizontal, 15)
        }
    }
}

struct NoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NoInfoView()
    }
}
