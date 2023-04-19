//
//  CustomTabBar.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/18/23.
//

import SwiftUI

enum Tabs: Int {
    case ecoDex = 0
    case map = 1
    case camera = 2
    case rankings = 3
    case profile = 4
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tabs
    @Namespace var animation
    
    var body: some View {
        HStack(alignment: .center) {
            
            Button {
                selectedTab = .ecoDex
            } label: {
                
                GeometryReader { geo in
                    
                    if selectedTab == .ecoDex {
                        Rectangle()
                            .foregroundColor(Color(.systemMint))
                            .frame(width: geo.size.width/2, height: 4)
                            .padding(.leading, geo.size.width/4)
                            .matchedGeometryEffect(id: "switch", in: animation)
                    }
                    
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "leaf.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(.systemMint))
                        
                        Text("EcoDex")
                            .font(Font.custom("LexendDeca-Regular", size: 12))
                            .foregroundColor(Color(.systemMint))
                    }
                    
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            
            Button {
                selectedTab = .map
            } label: {
                GeometryReader { geo in
                    
                    if selectedTab == .map {
                        Rectangle()
                            .foregroundColor(Color(.systemMint))
                            .frame(width: geo.size.width/2, height: 4)
                            .padding(.leading, geo.size.width/4)
                            .matchedGeometryEffect(id: "switch", in: animation)
                    }
                    
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "globe.central.south.asia.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(.systemMint))
                        Text("Map")
                            .font(Font.custom("LexendDeca-Regular", size: 12))
                            .foregroundColor(Color(.systemMint))
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            
            Button {
                selectedTab = .camera
            } label: {
                GeometryReader { geo in
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "camera.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color(.systemMint))
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            
            Button {
                selectedTab = .rankings
            } label: {
                GeometryReader { geo in
                    
                    if selectedTab == .rankings {
                        Rectangle()
                            .foregroundColor(Color(.systemMint))
                            .frame(width: geo.size.width/2, height: 4)
                            .padding(.leading, geo.size.width/4)
                            .matchedGeometryEffect(id: "switch", in: animation)
                    }
                    
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "crown.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(.systemMint))
                        Text("Rankings")
                            .font(Font.custom("LexendDeca-Regular", size: 12))
                            .foregroundColor(Color(.systemMint))
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            
            Button {
                selectedTab = .profile
            } label: {
                GeometryReader { geo in
                    
                    if selectedTab == .profile {
                        Rectangle()
                            .foregroundColor(Color(.systemMint))
                            .frame(width: geo.size.width/2, height: 4)
                            .padding(.leading, geo.size.width/4)
                            .matchedGeometryEffect(id: "switch", in: animation)
                    }
                    
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color(.systemMint))
                        Text("Profile")
                            .font(Font.custom("LexendDeca-Regular", size: 12))
                            .foregroundColor(Color(.systemMint))
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
        }
        .frame(height: 82)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.ecoDex))
    }
}
