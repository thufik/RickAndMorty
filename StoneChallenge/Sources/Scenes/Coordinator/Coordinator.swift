//
//  Coordinator.swift
//  StoneChallenge
//
//  Created by Rebecca Mello on 19/12/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
