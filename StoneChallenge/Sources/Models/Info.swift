//
//  Info.swift
//  StoneChallenge
//
//  Created by Rebecca Mello on 13/12/22.
//

import Foundation

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
