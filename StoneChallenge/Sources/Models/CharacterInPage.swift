//
//  Character.swift
//  StoneChallenge
//
//  Created by Rebecca Mello on 13/12/22.
//

import Foundation

struct CharacterInPage: Decodable {
    let info: Info?
    let results: [CharacterInfos]?
}
