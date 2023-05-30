//
//  ContractError.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/29/23.
//

import Foundation


struct ContractError:Error,LocalizedError,Identifiable {
    var id:String {description}
    let title:String
    let description:String
}
