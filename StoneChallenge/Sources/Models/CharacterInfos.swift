//
//  Character.swift
//  StoneChallenge
//
//  Created by Rebecca Mello on 13/12/22.
//

import Foundation

public struct CharacterInfos: Decodable, Equatable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: URL
}
