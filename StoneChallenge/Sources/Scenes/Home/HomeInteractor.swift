import Foundation

protocol HomeInteractorProtocol {
    func viewDidLoad()
    func loadCharacters()
    
    var characters: [CharacterInfos] { get }
}

final class HomeInteractor: HomeInteractorProtocol  {
    private let worker: HomeWorkerProtocol
    
    private let presenter: HomePresenterProtocol
    
    internal var characters: [CharacterInfos] = []
    
    private var page = 1
    private var canFetch: Bool = true
    
    init(worker: HomeWorkerProtocol, presenter: HomePresenterProtocol) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        presenter.initialSetupView()
        
        loadCharacters()
    }
    
    func loadCharacters() {
        if !canFetch { return }
        
        canFetch = false
        
        worker.getCharacters(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let chars):
                    self.characters.append(contentsOf: chars.results ?? [])
                    self.page += 1
                    self.presenter.reload()
                case .failure:
                    self.presenter.reload()
                }
                
                self.canFetch = true
            }
        }
    }
}


