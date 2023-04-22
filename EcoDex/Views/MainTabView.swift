//
//  MainTabView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/18/23.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = Tabs.ecoDex
    
    var body: some View {
        ZStack {
            Color("ThemeColor")
                .ignoresSafeArea()
            TabView(selection: $selectedTab) {
                EcoDexView()
                    .tabItem {
                        Image(systemName: "leaf\(selectedTab == .ecoDex ? ".fill" : "")")
                        Text("EcoDex")
                    }
                    .tag(Tabs.ecoDex)
                
                MapView()
                    .tabItem {
                        Image(systemName: "map\(selectedTab == .map ? ".fill" : "")")
                        Text("Map")
                    }
                    .tag(Tabs.map)
                
                CameraView()
                    .tabItem {
                        Image(systemName: "camera\(selectedTab == .camera ? ".fill" : "")")
                        Text("Camera")
                    }
                    .tag(Tabs.camera)
                
                RankingsView()
                    .tabItem {
                        Image(systemName: "crown\(selectedTab == .rankings ? ".fill" : "")")
                        Text("Rankings")
                    }
                    .tag(Tabs.rankings)
                
                ProfileView(plant: mockPlant[0])
                    .tabItem {
                        Image(systemName: "person.circle\(selectedTab == .profile ? ".fill" : "")")
                        Text("Profile")
                    }
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
            .offset(x: 0, y: UIScreen.main.bounds.height / 10 - 65)
        }
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

