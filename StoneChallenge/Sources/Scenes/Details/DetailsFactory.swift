import UIKit

enum DetailsFactory {
    static func make(character: CharacterInfos, navigationController: UINavigationController) -> UIViewController {
        let router = DetailsRouter(navigationController: navigationController)
        let presenter = DetailsPresenter(router: router)
        let interactor = DetailsInteractor(presenter: presenter)
        let viewController = DetailsViewController(interactor: interactor, character: character)
        
        presenter.view = viewController
        
        return viewController
    }
}
