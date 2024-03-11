import Foundation

protocol HomeInteractorProtocol {
    func viewDidLoad()
    func loadCharacters()
    func scrollViewDidScroll(offsetY: CGFloat, height: CGFloat, contentHeight: CGFloat)
    func clickFilter()
    func getCharacter(at index: Int) -> CharacterInfos
    func selectCellAt(index: Int)
}

final class HomeInteractor: HomeInteractorProtocol  {
    
    private let worker: HomeWorkerProtocol
    
    private let presenter: HomePresenterProtocol
    
    private var characters: [CharacterInfos] = []
    private var page = 1
    private var canFetch = true
    
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
            switch result {
            case .success(let chars):
                self.characters.append(contentsOf: chars.results ?? [])
                self.page += 1
                self.presenter.reload(with: self.characters)
            case .failure:
                self.presenter.reload(with: self.characters)
            }
            
            self.canFetch = true
        }
    }
    
    func scrollViewDidScroll(offsetY: CGFloat, height: CGFloat, contentHeight: CGFloat) {
        if offsetY > contentHeight - height {
            loadCharacters()
        }
    }
    
    func getCharacter(at index: Int) -> CharacterInfos {
        characters[index]
    }
    
    func clickFilter() {
        presenter.showFilter { characters in
            self.page = 1
            self.characters = characters
            self.presenter.reload(with: characters)
        }
    }
    
    func selectCellAt(index: Int) {
        let character = characters[index]
        
        presenter.showDetails(character: character)
    }
}


