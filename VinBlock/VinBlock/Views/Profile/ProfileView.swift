//
//  ProfileView.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/23/23.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var profileVM = ProfileViewModel()
    
    var body: some View {
        VStack(alignment: .center,spacing: 10) {
            Button(action: {
                print("Copy address")
            }, label: {
                Text(profileVM.address)
                    .font(.title3)
                    .truncationMode(.middle)
                    .lineLimit(1)
                
            })
            Text("\(profileVM.balanceOf)").font(.headline)
            VStack(){
                Text("Civic Pass").font(.title).bold()
                
            }.padding(10)
             .cornerRadius(5)
             
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

