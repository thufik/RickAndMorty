import Foundation

public enum Request {
    case characters(Int)
    case filter(String, String)
    
    public var url: URL {
        var defaultBaseUrl = InfoPlist.baseURL.rawValue.infoVariable()
        
        defaultBaseUrl.path = "/\(value)"
        defaultBaseUrl.queryItems = queryItems
        return defaultBaseUrl.urlUnwrapped
    }
    
    public var queryItems: [URLQueryItem] {
        switch self {
        case .characters(let page):
            return [
                URLQueryItem(name: "page", value: "\(page)"),
            ]
        case .filter(let name, let status):
            return [
                URLQueryItem(name: "name", value: "\(name)"),
                URLQueryItem(name: "status", value: "\(status.lowercased())"),
            ]
        }
    }
    
    
    public var value: String {
        switch self {
        case .characters, .filter:
            return "/api/character"
        }
    }
}
