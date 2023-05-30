//
//  Wallet.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/29/23.
//

import Foundation

struct Wallet {
    let address: String
    let data: Data
    let name:String
    let isHD:Bool
}


struct HDKey {
    let name:String?
    let address:String
}
