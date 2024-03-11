import Foundation
import UIKit

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    
    func reload(with characters: [CharacterInfos])
    func initialSetupView()
    func showFilter(reloadList: @escaping (_ characters: [CharacterInfos]) -> ())
    func showDetails(character: CharacterInfos)
}

final class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    
    private let router: HomeRouterProtocol
    
    init(router: HomeRouterProtocol) {
        self.router = router
    }
    
    func reload(with characters: [CharacterInfos]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CharacterInfos>()
        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        snapshot.appendItems(characters)
        
        DispatchQueue.main.async {
            self.view?.reloadCollectionData(with: snapshot)
        }
    }
    
    func initialSetupView() {
        view?.setupNavigation()
        view?.setupView()
        view?.setupConstraints()
    }
    
    func showFilter(reloadList: @escaping (_ characters: [CharacterInfos]) -> ()) {
        router.pushFilterScreen(reloadList: reloadList)
    }
    
    func showDetails(character: CharacterInfos) {
        router.pushDetailsScreen(character: character)
    }
}
