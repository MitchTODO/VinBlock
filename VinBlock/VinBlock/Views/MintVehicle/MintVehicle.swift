//
//  MintVehicle.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/26/23.
//

import SwiftUI

struct MintVehicle: View {
    
    @State private var vin = ""
    @State private var year = ""
    @State private var make = ""
    @State private var model = ""
    @State private var assetUri = ""
    

    var body: some View {
        VStack {
            Text("Mint New Vehicle")
                .font(.title2)
                .padding(5)
            TextField("Vin", text: $vin)
                .padding(5)
            TextField("Year", text:$year)
                .keyboardType(.numberPad)
                .padding(5)
            TextField("Make", text: $make)
                .padding(5)
            TextField("Model", text: $model)
                .padding(5)
            TextField("AssetUri", text: $assetUri)
                .padding(5)
             
            Button(action: {
                print("Pint")
            }, label: {
                Text("Mint")
            })
            .padding(5)
            .buttonStyle(.borderedProminent)
            
        }.multilineTextAlignment(.center)
        .background(Color.white)
        .textFieldStyle(.roundedBorder)
        .buttonStyle(.borderedProminent)
        .padding(5)
    }
}

struct MintVehicle_Previews: PreviewProvider {
    static var previews: some View {
        MintVehicle()
    }
}
