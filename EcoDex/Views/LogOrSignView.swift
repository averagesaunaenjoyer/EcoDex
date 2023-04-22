//
//  LogOrSignView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/19/23.
//

import SwiftUI

struct LogOrSignView: View {
    @State private var showingGetStarted = false
    @State private var showingSignIn = false
    
    var body: some View {
        ZStack {
            Color("ThemeColor")
                .ignoresSafeArea()
            VStack {
                Group {
                    Spacer()
                    Spacer()
                    Image("EcoDex")
                        .resizable()
                        .frame(width: 175, height: 175)
                        .scaledToFit()
                        .cornerRadius(30)
                }
                Spacer()
                Button(action: {
                    showingGetStarted = true
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 250, height: 50)
                            .foregroundColor(Color("SecondaryTheme"))
                            .cornerRadius(15)
                            .shadow(color: Color(.gray).opacity(0.4), radius: 5)
                            .padding(.vertical, -7)
                        Text("Get Started")
                            .font(.title3).bold()
                            .foregroundColor(.white)
                    }
                }
                .fullScreenCover(isPresented: $showingGetStarted) {
                    GetStartedView()
                }
                Button(action: {
                    showingSignIn = true
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 250, height: 50)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(color: Color(.gray).opacity(0.4), radius: 5)
                        Text("Sign In")
                            .font(.title3).bold()
                            .foregroundColor(Color("SecondaryTheme"))
                    }
                    .padding(.vertical, 10)
                }
                .fullScreenCover(isPresented: $showingSignIn) {
                    SignInView()
                }
                Spacer()
            }
        }
    }
}



struct LogOrSignView_Previews: PreviewProvider {
    static var previews: some View {
        LogOrSignView()
    }
}
