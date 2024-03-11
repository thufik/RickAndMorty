import Foundation

public enum Request {
    case characters(Int)
    
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
        }
    }
    
    
    public var value: String {
        switch self {
            case .characters:
                return "/api/character"
        }
    }
}
