import Foundation

public struct CharacterInfos: Codable, Equatable, Hashable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: URL
}
