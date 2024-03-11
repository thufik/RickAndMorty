import UIKit

enum HomeFactory {
    static func make() -> UIViewController {
        let worker = HomeWorker()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(worker: worker, presenter: presenter)
        let viewController = HomeViewController(interactor: interactor)
        
        presenter.view = viewController
        
        return viewController
    }
}
