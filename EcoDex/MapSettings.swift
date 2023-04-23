//
//  MapSettings.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/22/23.
//

import SwiftUI

final class MapSettings: ObservableObject {
    @Published var mapType = 0
    @Published var showElevation = 0
    @Published var showEmphasisStyle = 0
}
