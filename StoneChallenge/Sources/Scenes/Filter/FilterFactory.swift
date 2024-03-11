import UIKit

enum FilterFactory {
    static func make(navigationController: UINavigationController, reloadList: @escaping (_ characters: [CharacterInfos]) -> ()) -> UIViewController {
        let worker = FilterWorker()
        let router = FilterRouter(navigationController: navigationController)
        let presenter = FilterPresenter(router: router)
        let interactor = FilterInteractor(worker: worker, presenter: presenter, reloadList: reloadList)
        let viewController = FilterViewController(interactor: interactor)
        
        presenter.view = viewController
        
        return viewController
    }
}
