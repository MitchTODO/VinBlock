//
//  ContentView.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/22/23.
//
/*
import SwiftUI
import XDC3Swift

struct ContentView: View {
    @EnvironmentObject var authentication:Authentication
    
    @StateObject var contentVM = ContentViewModel()
    @State var showMint = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(contentVM.backgroundImage)
                VehiclePageView().environmentObject(contentVM)
            }
            .navigationTitle("VNFT")
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                        Button("Logout") {
                            //webSocket.disconnectSocket()
                            authentication.updateValidation(success: false,password:nil)
                        }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination:
                        ProfileView()
                        //.environmentObject(balance)
                        //.environmentObject(reputation)
                    ){
                        Image(systemName: "person.crop.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination:
                        MintVehicle()
                        //.environmentObject(balance)
                        //.environmentObject(reputation)
                    ){
                        Image(systemName: "plus")
                    }
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
