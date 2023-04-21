//
//  SignInView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/19/23.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var username = ""
    @State private var password = ""
    @State private var showingGetStarted = false
    @State private var showingMainView = false
    
    var body: some View {
        ZStack {
            Color("ThemeColor")
                .ignoresSafeArea()
            VStack(alignment: .center) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("TertiaryTheme"))
                            .padding(.horizontal, 25)
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("      Welcome Back!")
                        .font(.system(size: 36)).bold()
                        .foregroundColor(Color("TertiaryTheme"))
                    Spacer()
                    Spacer()
                    Spacer()
                }
                Image("EcoGuy2")
                    .resizable()
                    .frame(width: 150, height: 150)
                Group {
                    ZStack {
                        Rectangle()
                            .frame(width: 250, height: 40)
                            .cornerRadius(15)
                            .foregroundColor(.white)
                            .padding(.vertical, 7)
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.gray)
                                .padding(.leading, 85)
                            TextField("Username", text: $username)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                    }
                    ZStack {
                        Rectangle()
                            .frame(width: 250, height: 40)
                            .cornerRadius(15)
                            .foregroundColor(.white)
                            .padding(.vertical, 7)
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray)
                                .padding(.leading, 85)
                            TextField("Password", text: $password)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                    }
                }
                HStack {
                    Text("New User? ")
                        .font(.headline).bold()
                        .foregroundColor(.white)
                    Button(action: {
                        showingGetStarted = true
                    }) {
                        Text("Get started")
                            .font(.headline).bold()
                            .foregroundColor(Color("SecondaryTheme"))
                            .underline()
                    }
                    .fullScreenCover(isPresented: $showingGetStarted) {
                        GetStartedView()
                    }
                }
                Spacer()
                Button(action: {
                    showingMainView = true
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 150, height: 50)
                            .cornerRadius(25)
                            .foregroundColor(Color("TertiaryTheme"))
                            .shadow(color: Color(.gray).opacity(0.4), radius: 5)
                        Text("Sign In")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .fullScreenCover(isPresented: $showingMainView) {
                    MainTabView()
                }
                Spacer()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
