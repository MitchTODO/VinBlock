//
//  ContractServices.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/23/23.
//

import Web3Core
import web3swift

import BigInt

class ContractServices {
    
    //static let shared = ContractServices()
    private var w3:Web3
    
    private var wallet:Wallet
    private var VNFTContract:Web3.Contract
    
    init() async {
        let keystore = WalletServices.shared.keystoreManager!
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams);
        let address = keystore.addresses!.first!.address
        wallet = Wallet(address: address, data: keyData, name: "User", isHD: true)
        
        let keystoreManager = KeystoreManager([keystore])
        
        let provider = await Web3HttpProvider(URL(string: apothemTestnet.rpcEndpoint)!, network: .Custom(networkID: BigUInt(apothemTestnet.chainId)))
        
        w3 = Web3(provider: provider!)
        w3.addKeystoreManager(keystoreManager)
        
        VNFTContract = w3.contract(VNFTAbi, at:VNFTContractAddress, abiVersion: abiVerison)!
    }
    
    // MARK: getWallet
    /// Returns wallet struct
    func getWallet() -> Wallet {
        return self.wallet
    }
    
    // MARK: read
    /// async method to read data from a given contract method
    ///
    ///
    /// - Parameters :
    ///               `contractId` : Enum type - as contract used to read from
    ///
    ///               `method` : String - called contract methods
    ///
    ///               `parameters` :  [AnyObject] - parameters associated with contract call
    ///
    /// - Returns: completion: <String:Any> on success , `ContractError` on failure
    ///
    func read(method:String,parameters:[AnyObject] ) async {
        let readOp = VNFTContract.createReadOperation(method,parameters: parameters)!
        readOp.transaction.from = EthereumAddress(wallet.address)
        do {
            let response = try await readOp.callContractMethod()
        }catch {
            print(error)
        }
    }
    
    // MARK: write
    /// async method to write data to a given contract method
    ///
    /// - Parameters :
    ///                 - `method` : String - called contract methods
    ///                 - `parameters` :  [AnyObject] - parameters associated with contract call
    ///                 - `password`:String - password of keymanager used to sign transaction
    ///
    /// - Returns: completion: `TransactionSendingResult` on success , `ContractError` on failure
    ///
    //func write(method:String,parameters:[AnyObject],password:String) async {
        //let abiString = "[]" // some ABI string
        //let bytecode = Data.fromHex("") // some ABI bite sequence
        //let contract = VNFTContract.contract(abiString, at: nil, abiVersion: 2)!
        //let parameters: [Any] = []
        
        //deployOp.transaction.from = "" // your address
        //deployOp.transaction.gasLimitPolicy = .manual(3000000)
        //let result = try await deployTx.writeToChain(password: "web3swift")
    //}
}

