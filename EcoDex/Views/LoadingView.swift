//
//  LoadingView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/22/23.
//

//import SwiftUI
//
//struct LoadingView<Content>: View where Content: View {
//    @Binding var isLoading: Bool
//    var content: () -> Content
//    
//    var body: some View {
//        ZStack {
//            content()
//                .disabled(isLoading)
//                .blur(radius: isLoading ? 3 : 0)
//            
//            if isLoading {
//                VStack {
//                    ProgressView()
//                        .scaleEffect(2)
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.white.opacity(0.5))
//            }
//        }
//    }
//}
