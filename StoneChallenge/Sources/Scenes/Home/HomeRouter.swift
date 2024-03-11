import Foundation
import UIKit

protocol HomeRouterProtocol {
    func pushFilterScreen(reloadList: @escaping (_ characters: [CharacterInfos]) -> ())
    func pushDetailsScreen(character: CharacterInfos)
}

final class HomeRouter: HomeRouterProtocol {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pushFilterScreen(reloadList: @escaping (_ characters: [CharacterInfos]) -> ()) {
        let filterScreen = FilterFactory.make(navigationController: navigationController, reloadList: reloadList)
        
        navigationController.pushViewController(filterScreen, animated: true)
    }
    
    func pushDetailsScreen(character: CharacterInfos) {
        let detailsScreen = DetailsFactory.make(character: character, navigationController: navigationController)
        
        navigationController.pushViewController(detailsScreen, animated: true)
    }
}
