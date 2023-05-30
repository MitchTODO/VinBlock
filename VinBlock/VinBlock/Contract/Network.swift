//
//  Network.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/23/23.
//

import Foundation
import BigInt

// Testnet settings
let apothemTestnet = Network(chainId: 51 , rpcEndpoint: "https://rpc.apothem.network")
let apothemWebSocketURI = "wss://ws.apothem.network"

struct Network {
    let chainId:Int
    let rpcEndpoint:String
}


let civicUrl = "/pass/ethereum/xdcApothem"
