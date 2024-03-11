import Foundation
import RAMRequestManager

protocol HomeWorkerProtocol {
    func getCharacters(page: Int, completion: @escaping (Result<CharacterInPage, ResultError>) -> ())
}

final class HomeWorker: HomeWorkerProtocol {
    private let service: Api
    
    init(service: Api = Api()) {
        self.service = service
    }
    
    func getCharacters(page: Int, completion: @escaping (Result<CharacterInPage, ResultError>) -> ()) {
        service.request(
            url: Request.characters(page).url,
            method: .GET,
            with: nil,
            completion: completion
        )
    }
}
