//
//  APIService.swift
//  StoneChallenge
//
//  Created by Rebecca Mello on 13/12/22.
//

import Foundation
import RAMRequestManager

enum ErrorMessages: String, Error {
    case invalidServerResponse = "Invalid response from server"
    case invalidData = "The data received from the server was not valid"
}

enum ApiKeys {
    static let baseURL: String = "rickandmortyapi.com"
}

enum Endpoints: String {
    case character = "/api/character"
}

