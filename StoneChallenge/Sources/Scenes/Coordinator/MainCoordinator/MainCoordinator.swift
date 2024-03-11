//
//  MainCoordinator.swift
//  StoneChallenge
//
//  Created by Rebecca Mello on 19/12/22.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeFactory.make()
        navigationController.pushViewController(vc, animated: false)
    }
}
