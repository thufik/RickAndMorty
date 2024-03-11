import Foundation

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    
    func reload()
    func initialSetupView()
}

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    
    func reload() {
        view?.reloadCollectionData()
    }
    
    func initialSetupView() {
        view?.setupNavigation()
        view?.setupView()
        view?.setupConstraints()
    }
}
