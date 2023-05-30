//
//  VehiclePageView.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/25/23.
//

import SwiftUI
import BigInt

struct VehiclePageView: View {
    @EnvironmentObject var contentVM:ContentViewModel
    @State var showOnTap = false
    var body: some View {
        VStack{
            Group {
                 TabView {
                     VehicleView(vehicle: Vehicle(vinId: "123", year: BigUInt(123), make: "BMW", model: "M5", assetUri: "carImage"), showImage: $showOnTap).onTapGesture {}
                     
                     VehicleView(vehicle: Vehicle(vinId: "123", year: BigUInt(123), make: "BMW", model: "M6", assetUri: "carImage2"), showImage: $showOnTap).onTapGesture {}
                 }
                 .tabViewStyle(PageTabViewStyle())
             }
            
                 HStack {
                     Button(action: {
                         print("Recalls")
                     }, label: {
                         VStack{
                             Image(systemName: "car.side.and.exclamationmark")
                             Text("Recalls").font(.caption)
                         }
                     }).buttonStyle(.bordered)
                     
                     Button(action: {
                         print("Service")
                     }, label: {
                         VStack{
                             Image(systemName: "gearshape.2.fill")
                             Text("Service").font(.caption)
                         }
                     }).buttonStyle(.bordered)

                     Button(action: {
                         print("Transfer")
                     }, label: {
                         VStack{
                             Image(systemName: "arrowshape.turn.up.right.fill")
                             Text("Transfer").font(.caption)
                         }
                     }).buttonStyle(.bordered)
                     
                 }
        }
    }
}

struct VehiclePageView_Previews: PreviewProvider {
    static var previews: some View {
        VehiclePageView()
    }
}
