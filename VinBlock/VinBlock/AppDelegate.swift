//
//  AppDelegate.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/27/23.
//

import Foundation
import UIKit
import OAuthSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //print("Your code here")
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey  : Any] = [:]) -> Bool {
      if url.host == "oauth-callback" {
        OAuthSwift.handle(url: url)
      }
      return true
    }
}
