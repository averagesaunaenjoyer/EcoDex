//
//  CustomNavTitle.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/18/23.
//

import SwiftUI

struct CustomNavTitle: View {
    var body: some View {
        Image("EcoGuy2")
            .resizable()
            .frame(width: 95, height: 90, alignment: .center)
            .clipped()
            .cornerRadius(20)
    }
}

struct CustomNavTitle_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavTitle()
    }
}
