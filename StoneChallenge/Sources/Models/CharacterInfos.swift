import Foundation

public struct CharacterInfos: Codable, Equatable, Hashable {
    let uuid = UUID()
    
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: String
    let image: URL
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    public static func ==(lhs: CharacterInfos, rhs: CharacterInfos) -> Bool {
        lhs.uuid == rhs.uuid
    }
}

enum Status: String, Codable {
    case Alive
    case Dead
    case unknown
}

