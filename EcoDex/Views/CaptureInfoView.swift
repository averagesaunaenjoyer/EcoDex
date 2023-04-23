//
//  CaptureInfoView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/23/23.
//

import SwiftUI

struct CaptureInfoView: View {
    var body: some View {
        ZStack {
            Color("TertiaryTheme")
                .ignoresSafeArea()
            VStack(alignment: .center) {
                HStack {
                    Image("Verbena")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(10)
                        .offset(x: -32)
                    Text("Verbena")
                        .foregroundColor(.white)
                        .font(.title)
                }
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .scaleEffect(3)
                        .padding()
                    VStack(alignment: .leading) {
                        Text("Caught by: Nitbro")
                        Text("Location: 34.0092, -118.2942")
                        Text("Time Caught: 4/22, 3:57 P.M.")
                    }
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.vertical, 10)
                }
            }
        }
    }
}

struct CaptureInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CaptureInfoView()
    }
}
