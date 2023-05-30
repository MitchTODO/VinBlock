//
//  ContractViewModel.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/23/23.
//

import SwiftUI
//import XDC3Swift
import BigInt
import CryptoSwift
import Web3Core

class ContentViewModel: ObservableObject {
    
    @Published var vehicleCount:BigUInt = 0
    @Published var ownedVehiclesByTokenId:[BigUInt] = []
    @Published var error:Error? = nil
    
    //public var client:XDCClient? = nil
    //public var clientVNFT:VNFT? = nil
    //public var client721:XRC721? = nil
    
    // background image 
    @Published var backgroundImage:String = ""
    
    init() {
        //guard let clientUrl = URL(string: apothemTestnet.rpcEndpoint) else { return }
        //client = XDCClient(url: clientUrl)
        //clientVNFT = VNFT.init(client: client!)
        //client721 = XRC721(client: client!)
        
        // get token balance
        //getBalanceOf()
        
        // TODO wrap balance amount for fetch for owned vehicles
        //getOwnedVehicles()
    }
    
    /*
    // MARK: getBalanceOf
    /// Fetches token balance
    ///
    func getBalanceOf() {
        client721!.balanceOf(contract: VNFTContractAddress, address: WalletServices.shared.getWalletAddress()!) { (error, balanceOf) in
            DispatchQueue.main.async { [unowned self] in
                if error == nil {
                    self.vehicleCount = balanceOf!
                }else {
                    self.error = error
                }
            }
        }
    }
    
    // MARK: mintVehicle
    /// Mint vehicles NFT's
    ///
    func mintVehicle(vin:String, year:BigUInt, make:String, model:String, assetUri:String) {
        let inputData = Data(vin.utf8)
        let vinId = inputData.sha3(.keccak256)
        print(vinId)
        clientVNFT!.mintVehicle(contract: VNFTContractAddress, account: WalletServices.shared.getAccount()!, _vinId: vinId, _year: year, _make: make, _model: model, _assetUri: assetUri) { result in
            print(result)
        }
    }
    
    // MARK: getOwnedVehicles
    /// Get owned vehicles
    ///
    func getOwnedVehicles() {
        clientVNFT!.getOwnedVehicles(contract: VNFTContractAddress, _owner: WalletServices.shared.getWalletAddress()!) { (error, ownedTokens) in
            if error != nil {
                // error on owned vehicles
                return
            }
            // Dispath on main thread
            //self.ownedVehiclesByTokenId = ownedTokens ?? []
            
            if ownedTokens == nil {
                // empty owned tokens
            }else{
                
                // check request count
                for tokenId in ownedTokens! {
                    print(tokenId)
                    print("Get vehicle by token id")
                    self.getVehicleByTokenId(tokenId: tokenId)
                }
            }
            
        }
    }
    
    // MARK: getVehicleByTokenId
    /// Get owned vehicles
    ///
    /// - Parameters : tokenId: BigUInt
    ///
    func getVehicleByTokenId(tokenId:BigUInt) {
        clientVNFT!.getVehicleByTokenId(contract: VNFTContractAddress, tokenId: tokenId) { (error,vehicles) in
            print(vehicles)
            print(error)
        }
    }
    
    // MARK: getVehicleServiceCount
    func getVehicleServiceCount(vehicleId:Data32) {
        clientVNFT!.getVehicleServiceCount(contract: VNFTContractAddress, vehicleId: vehicleId) { (error, vehicleId) in
            print(vehicleId)
            print(error)
        }
    }
    
    // MARK: getVehicleService
    func getVehicleService(vehicleId:Data32,_startIndex:BigUInt,_amount:BigUInt) {
        clientVNFT!.getVehicleService(contract: VNFTContractAddress, vehicleId: vehicleId, _startIndex: _startIndex, _amount: _amount) { (error, service) in
            print(error)
            print(service)
        }
    }
    
    // MARK: getRecalls
    ///
    func getRecalls(_make:String,_model:String,_year:BigUInt) {
        clientVNFT!.getRecalls(contract: VNFTContractAddress,_make:_make,_model:_model,_year:_year) { (error, recalls) in
            print(error)
            print(recalls)
        }
    }
    
    // MARK: issueReCall
    /// IssueReCall from manfacture
    /// - Note:
    ///
    /// - Parameters :
    ///
    func issueReCall() {
        let year = BigUInt(927309964)
        let make = "Bentey"
        let model = "Azuer"
        
        clientVNFT!.issueReCall(contract: VNFTContractAddress, account:  WalletServices.shared.getAccount()!, _make: make, _model: model, _year: year, _assetUri: "Instagram") { result in
            print(result)
        }
    }
    */
}
