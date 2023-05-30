//
//  ProfileViewModel.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/23/23.
//

import Foundation
//import XDC3Swift
import Web3Core

class ProfileViewModel: ObservableObject {
    
    @Published var address = ""
    @Published var balanceOf = ""
    
    private var address:EthereumAddress? = nil
    //private var xdcAddress:XDCAddress? = nil

    init() {
        
        //xdcAddress = WalletServices.shared.getWalletAddress()
        //if xdcAddress == nil {return} // user cannot have empty address
        //address = xdcAddress!.value
        getBalanceOf()
        
    }
    
    func getBalanceOf() {
        /*
        ContractServices.shared.client!.eth_getBalance(address: xdcAddress!, block: .Latest) { (error, currentPrice) in
            if (error != nil) {
              return
            }
            
            // convert to eth ie 18
            let value = Double(currentPrice!) / pow(10, 18)
            
            DispatchQueue.main.async {
                self.balanceOf = "XDC \(value.description)"
            }
        }
        */
    }

}
