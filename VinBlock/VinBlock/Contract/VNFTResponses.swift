//
//  VNFTResponse.swift
//  VinBlock
//
//  Created by mitchell tucker on 5/23/23.
//
/*
import Foundation
import XDC3Swift
import BigInt

public enum VNFTResponses {
    
    public struct balanceResponse: ABIResponse {
        public static var types: [ABIType.Type] = [ BigUInt.self ]
        public let value: BigUInt
        
        public init?(values: [ABIDecoder.DecodedValue]) throws {
            self.value = try values[0].decoded()
        }
    }
    
    public struct ownerResponse: ABIResponse {
        public static var types: [ABIType.Type] = [ XDCAddress.self ]
        public let value: XDCAddress
        
        public init?(values: [ABIDecoder.DecodedValue]) throws {
            self.value = try values[0].decoded()
        }
    }
    
    public struct ownedVehiclesResponse: ABIResponse {
        public static var types: [ABIType.Type] = [ABIArray<BigUInt>.self]
        public let value: [BigUInt]
        
        public init?(values:[ABIDecoder.DecodedValue]) throws {
            self.value = try values[0].decodedArray()
        }
    }
    
    public struct getVehicleServiceCount:ABIResponse {
        public static var types: [ABIType.Type] = [BigUInt.self]
        public let value:BigUInt
        
        public init?(values:[ABIDecoder.DecodedValue]) throws {
            self.value = try values[0].decoded()
        }
    }
    
    public struct getRecallResponse:ABIResponse {
        public static var types: [ABIType.Type] = [ABIArray<Data32>.self]
        public let value: [Data32]
        
        public init?(values:[ABIDecoder.DecodedValue]) throws {
            self.value = try values[0].decodedArray()
        }
    }
    
    /*
    public struct vehicleTupleResponse: ABIResponse {
        public static var types: [ABIType.Type] = [ ABITuple.self ]
        public let value: [ABITuple(Data32, BigUInt, String, String, String)]
        
        public init?(values:[ABIDecoder.DecodedValue]) throws {
            self.value = try values[0].decoded()
        }
    }
    */
}
*/
