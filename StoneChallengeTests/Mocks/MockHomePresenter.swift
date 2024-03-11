import Foundation
import RAMRequestManager
@testable import RickAndMorty

class MockHomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    
    var reloadCalled = false
    var initialSetupViewCalled = false
    var showFilterCalled = false
    
    func reload(with characters: [CharacterInfos]) {
        reloadCalled = true
    }
    
    func initialSetupView() {
        initialSetupViewCalled = true
    }
    
    func showFilter(reloadList: @escaping ([CharacterInfos]) -> ()) {
        showFilterCalled = true
    }
}

class MockHomeWorker: HomeWorkerProtocol {
    private let success: Bool
    
    init(success: Bool) {
        self.success = success
    }
    
    func getCharacters(page: Int, completion: @escaping (Result<CharacterInPage, ResultError>) -> ()) {
        if success {
            completion(.success(CharacterInPageStub.createMock()))
        } else {
            completion(.failure(.badRequest))
        }
    }
}

struct CharacterInPageStub {
    static func createMock() -> CharacterInPage {
        let info = Info(count: 1, pages: 1, next: nil, prev: nil)
        let characterInfos = CharacterInfos(name: "Test Character", status: .Alive, species: "Human", type: "Main", gender: "Male", image: URL(string: "https://example.com/image.jpg")!)
        return CharacterInPage(info: info, results: [characterInfos])
    }
}
