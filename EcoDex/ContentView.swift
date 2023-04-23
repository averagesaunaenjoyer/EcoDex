//
//  ContentView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var mapSettings = MapSettings()
    @State var mapType = 0
    @State var showElevation = 0
    @State var showEmphasis = 0
    
    var body: some View {
        ZStack {
            NewMapView()
                .ignoresSafeArea().environmentObject(mapSettings)
        }
    }
}
