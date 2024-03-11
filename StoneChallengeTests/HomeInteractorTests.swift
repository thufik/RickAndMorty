import XCTest
@testable import RickAndMorty

class HomeInteractorTests: XCTestCase {


    func testViewDidLoadSuccess() {
        let mockWorker = MockHomeWorker(success: true)
        let mockPresenter = MockHomePresenter()
        let interactor = HomeInteractor(worker: mockWorker, presenter: mockPresenter)
        
        interactor.viewDidLoad()

        
        XCTAssertTrue(mockPresenter.initialSetupViewCalled)
        XCTAssertTrue(mockPresenter.reloadCalled)
    }

    func testViewDidLoadFailure() {
        let mockWorker = MockHomeWorker(success: false)
        let mockPresenter = MockHomePresenter()
        let interactor = HomeInteractor(worker: mockWorker, presenter: mockPresenter)
        
        interactor.viewDidLoad()

        // Assert that the presenter's initialSetupView method is called
        XCTAssertTrue(mockPresenter.initialSetupViewCalled)
        XCTAssertTrue(mockPresenter.reloadCalled)
    }
}
