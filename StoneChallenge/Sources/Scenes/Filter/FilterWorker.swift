import Foundation
import RAMRequestManager

protocol FilterWorkerProtocol {
    func filterCharacters(name: String, status: Status, completion: @escaping (Result<CharacterInPage, ResultError>) -> ())
}

final class FilterWorker: FilterWorkerProtocol {
    private let service: Api
    
    init(service: Api = Api()) {
        self.service = service
    }
    
    func filterCharacters(name: String, status: Status, completion: @escaping (Result<CharacterInPage, ResultError>) -> ()) {
        service.request(
            url: Request.filter(name, status.rawValue).url,
            method: .GET,
            with: nil,
            completion: completion
        )
    }
}
