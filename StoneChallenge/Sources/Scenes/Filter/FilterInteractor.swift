import Foundation

protocol FilterInteractorProtocol {
    func viewDidLoad()
    func filter()
    func status(status: Status?)
    func filterEditing(with text: String?)
}

final class FilterInteractor: FilterInteractorProtocol  {
    private let worker: FilterWorkerProtocol
    
    private let presenter: FilterPresenterProtocol
    
    private var reloadList: (_ characters: [CharacterInfos]) -> ()
    
    private var filterText: String?
    
    private var status: Status?
    
    init(worker: FilterWorkerProtocol, presenter: FilterPresenterProtocol, reloadList: @escaping (_ characters: [CharacterInfos]) -> ()) {
        self.worker = worker
        self.presenter = presenter
        self.reloadList = reloadList
    }
    
    func viewDidLoad() {
        
    }
    
    func filter() {
        if let filterText, let status {
            worker.filterCharacters(name: filterText, status: status) { result in
                switch result {
                case .success(let characters):
                    self.reloadList(characters.results ?? [])
                    self.presenter.reloadList()
                case .failure:
                    print("falha")
                }
            }
        }
    }
    
    func status(status: Status?) {
        self.status = status
        
        presenter.controlButtonColors(status: status)
        presenter.validateButtonState(filterText: filterText, status: status)
    }
    
    func filterEditing(with text: String?) {
        self.filterText = text
        
        presenter.validateButtonState(filterText: filterText, status: status)
    }
}

