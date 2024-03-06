//
//  APIService.swift
//  StoneChallenge
//
//  Created by Rebecca Mello on 13/12/22.
//

import Foundation

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

class APIService {
    
    let session = URLSession.shared
    
    private func characterURL(page : Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = ApiKeys.baseURL
        components.path = Endpoints.character.rawValue
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
        ]

        let url = components.url
        return url
    }
    
    func getCharacters(page : Int, _ completionHandler: @escaping (Result<[CharacterInfos], ErrorMessages>) -> Void) {
        guard let url = characterURL(page: page) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completionHandler(.failure(.invalidServerResponse))
                    return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let characters = try decoder.decode(CharacterInPage.self, from: data)
                    if let characters = characters.results {
                        completionHandler(.success(characters))
                    } else {
                        completionHandler(.failure(.invalidData))
                    }
                } catch {
                    completionHandler(.failure(.invalidData))
                }
            }
        }.resume()
    }
    
}
