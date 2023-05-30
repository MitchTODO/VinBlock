//
//  VehicleView.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/25/23.
//

import SwiftUI
import BigInt

struct VehicleView: View {
    let vehicle:Vehicle
    
    @Binding var showImage: Bool
    
    var body: some View {
        ZStack{
            Image(vehicle.assetUri)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 500)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.clear, lineWidth: 0))
                .shadow(radius: 20)
                .cornerRadius(10)
            
            VStack {
                Text("\(vehicle.year.description) \(vehicle.make) \(vehicle.model)")
                        .padding(5)
                        .font(.title2)
                        .lineLimit(4)
                        
                Spacer()
            }
        }
    }
}

struct VehicleView_Previews: PreviewProvider {
    static var previews: some View {
        
        var bindingValue = false
        let bind = Binding(get: { bindingValue }, set: { bindingValue = $0 })
        
        let vehicle = Vehicle(vinId: "213", year: BigUInt(123), make: "Make", model: "Model", assetUri: "carImage2")
        VehicleView(vehicle: vehicle, showImage: bind)
    }
}
