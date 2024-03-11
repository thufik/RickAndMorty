import Foundation
import UIKit

protocol FilterRouterProtocol {
    func popToFilter()
}

final class FilterRouter: FilterRouterProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func popToFilter() {
        navigationController.popViewController(animated: true)
    }
}
