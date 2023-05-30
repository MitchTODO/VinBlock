//
//  Authentication.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/23/23.
//

import SwiftUI

// MARK: Authentication
/// Authentication object for login - out service
class Authentication:ObservableObject {
    @Published var isValidated = false
    var password = ""
    
    func updateValidation(success:Bool,password:String?) {
        withAnimation {
            isValidated = success
            self.password = password ?? ""
        }
    }
}
