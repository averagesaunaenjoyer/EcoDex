//
//  GetStartedView.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/19/23.
//

import SwiftUI

struct GetStartedView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var showingSignIn = false
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
//                HStack {
//                    Spacer()
//                    Text("     Make an Account")
//                        .font(.system(size: 36)).bold()
//                        .foregroundColor(Color("TertiaryTheme"))
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                }
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
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                                .padding(.leading, 85)
                            TextField("Email", text: $email)
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
                    Text("Already have one? ")
                        .font(.headline).bold()
                        .foregroundColor(.white)
                    Button(action: {
                        showingSignIn = true
                    }) {
                        Text("Sign in")
                            .font(.headline).bold()
                            .foregroundColor(Color("SecondaryTheme"))
                            .underline()
                    }
                    .fullScreenCover(isPresented: $showingSignIn) {
                        SignInView()
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
                        Text("Sign Up")
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

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedView()
    }
}
