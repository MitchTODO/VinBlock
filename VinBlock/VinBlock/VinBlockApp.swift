//
//  VinBlockApp.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/22/23.
//

import SwiftUI

@main
struct VinBlockApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var authentication = Authentication()
    
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                ContentView().environmentObject(authentication)
            }else {
                LoginView().environmentObject(authentication)
            }
        }
    }
}
