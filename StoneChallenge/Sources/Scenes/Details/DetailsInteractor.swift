import Foundation

protocol DetailsInteractorProtocol {
    func viewDidLoad()
}

final class DetailsInteractor: DetailsInteractorProtocol {
    private let presenter: DetailsPresenterProtocol
    
    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func viewDidLoad() {

    }
}
