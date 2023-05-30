//
//  LoginViewModel.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/23/23.
//

import SwiftUI

class LoginViewModel:ObservableObject {
    
    @Published var credentials = Credentials()
    
    @Published var privateKey = ""
    @Published var showProgressView = false
    @Published var hasKeyStore = WalletServices.shared.hasKeyStore
    
    init() {
        //WalletServices.shared.createWallet()
    }
    
    func login(completion: @escaping(Bool) -> Void) {
        if hasKeyStore {
            let success = WalletServices.shared.verifyKeyStore(password: credentials.password)
            completion(success)
        }else{
            // password checksum
            let success = WalletServices.shared.createWallet(password: credentials.password)
            completion(success)
        }
        
    }
    
}
