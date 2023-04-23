//
//  MainTabView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/18/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = Tabs.ecoDex
    @State var photosWithLocations:
        [PhotoWithLocation] = []
    
    var body: some View {
        ZStack {
            Color("ThemeColor")
                .ignoresSafeArea()
            TabView(selection: $selectedTab) {
                EcoDexView()
                    .tag(Tabs.ecoDex)
                
                MapView()
                    .tag(Tabs.map)
                
                CameraView()
                    .tag(Tabs.camera)
                
                ExploreView()
                    .tag(Tabs.explore)
                
                ProfileView(plant: mockPlant[0])
                    .tag(Tabs.profile)
            }
            .overlay(
                CustomTabBar(selectedTab: $selectedTab)
                    .frame(height: 92)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
                    .alignmentGuide(.bottom) { d in d[.bottom] }
                    , alignment: .bottom
            )
            .ignoresSafeArea(.keyboard)
            .offset(x: 0, y: UIScreen.main.bounds.height / 10 - 65)
        }
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

//struct MapViewWrapper: UIViewControllerRepresentable {
//    var photosWithLocations: [PhotoWithLocation]
//
//    func makeUIViewController(context: Context) -> MapViewController {
//        let viewController = MapViewController()
//        viewController.photosWithLocations = photosWithLocations
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
//        // Leave this empty for now
//    }
//}
