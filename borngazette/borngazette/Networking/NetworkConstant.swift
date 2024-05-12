//
//  NetworkConstant.swift
//  BornGazette
//
//  Created by Rafael Melo on 11/05/24.
//

import Foundation

class NetworkConstant {
    public static var shared = NetworkConstant()
    
    public var apiKey: String {
        get {
            "&apiKey=676d68f0e1e241e9aa699d0b5fa4f37c"
        }
    }
    
    public var serverAddress: String {
        get {
            "https://newsapi.org/v2/everything"
        }
    }
    
    public var techNews: String {
        get {
            NetworkConstant.shared.serverAddress + "?q=tecnologia&language=pt" + NetworkConstant.shared.apiKey
        }
    }
}
