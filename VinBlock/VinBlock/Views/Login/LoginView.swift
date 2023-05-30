//
//  LoginView.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/23/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication:Authentication
    
    @State private var animateGradient = false
    
    var body: some View {
        ZStack(alignment: .top){
            LinearGradient(colors: [Color("PrimaryOrange"), Color("XDCBlue")], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: 8.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                Text("Vin Block").font(.title).bold().padding()
                Spacer()
                VStack(alignment: .leading, spacing: 10){
                    Text(loginVM.hasKeyStore ? "Login":"Create New Wallet").font(.title)
                    Text(loginVM.hasKeyStore ? "Password":"New Password").font(.subheadline)
                        .bold()

                    TextField("",text: $loginVM.credentials.password)
                    HStack{
                        if loginVM.showProgressView{
                            ProgressView().tint(.blue)
                            Spacer()
                        }else{
                            Spacer()
                            Button{
                                loginVM.showProgressView = true
                                loginVM.login { success in
                                        // update validation
                                        authentication.updateValidation(success: success,password:loginVM.credentials.password)
                                        loginVM.showProgressView = false
                                }
                            }label: {
                                Text("Login")
                            }
                            Spacer()
                        }
                        
                    }
                }
                Spacer()
            }.textFieldStyle(.roundedBorder)
             .padding(10)
             .buttonStyle(.borderedProminent)
            .navigationTitle("Crypto Passenger")
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

