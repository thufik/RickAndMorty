import Foundation
import UIKit

protocol FilterPresenterProtocol: AnyObject {
    func validateButtonState(filterText: String?, status: Status?)
    func controlButtonColors(status: Status?)
    func reloadList()
}

final class FilterPresenter: FilterPresenterProtocol {
    weak var view: FilterViewProtocol?
    
    private var previousStatus: Status?
    
    private let router: FilterRouterProtocol
    
    init(router: FilterRouterProtocol) {
        self.router = router
    }
    
    func validateButtonState(filterText: String?, status: Status?) {
        if (filterText != nil || status != nil) {
            view?.setFilterButtonState(isEnabled: true)
        } else {
            view?.setFilterButtonState(isEnabled: false)
        }
    }
    
    func controlButtonColors(status: Status?) {
        if let previousStatus = previousStatus {
            view?.statusButtons.filter({$0.titleLabel?.text == previousStatus.rawValue}).first?.backgroundColor = .black
        }
        
        self.previousStatus = status
        
        view?.statusButtons.filter({$0.titleLabel?.text == status?.rawValue}).first?.backgroundColor = UIColor(named: "Green")
    }
    
    func reloadList() {
        DispatchQueue.main.async {
            self.router.popToFilter()
        }
    }
    
}
