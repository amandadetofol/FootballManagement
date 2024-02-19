//
//  DeleteTeamInteractorTests.swift
//  PatotaProTests
//
//  Created by Amanda Detofol on 16/02/24.
//

import XCTest
@testable import PatotaPro

final class DeleteTeamInteractorTests: XCTestCase {
    
    private var coordinatorMock: DeleTeamCoordinatorMock?
    private var presenterMock: DeleteTeamPresenterMock?
    private var workerMock: DeleteTeamWorkerMock?
    private var sut: DeleteTeamInteractor?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        coordinatorMock = DeleTeamCoordinatorMock()
        presenterMock = DeleteTeamPresenterMock()
        workerMock = DeleteTeamWorkerMock()
        
        guard let coordinatorMock ,
              let presenterMock,
              let workerMock else {
            XCTFail("Mocks not initialized")
            return
        }
        
        sut = DeleteTeamInteractor(
            worker: workerMock,
            presenter: presenterMock,
            coordinator: coordinatorMock)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
        workerMock = nil
        presenterMock = nil
        coordinatorMock = nil
    }
    
    func test_viewDidLoad_shouldReturnWasCalled() {
        guard let presenterMock = presenterMock else {
            XCTFail("Presenter mock not initialized")
            return
        }
        
        sut?.viewDidLoad()
        
        XCTAssertTrue(presenterMock.updateViewWasCalled)
        XCTAssertFalse(presenterMock.updateViewForIdTextFieldErrorStateWasCalled)
    }
    
    func test_handleConfirmButtonTap_emptyId_errorShouldBeCalled() {
        guard let presenterMock else {
            XCTFail("Presenter mock not initialized")
            return
        }
        
        let id = ""
        sut?.handleConfirmButtonTap(id: id)
        
        XCTAssertTrue(presenterMock.updateViewForIdTextFieldErrorStateWasCalled)
        
        XCTAssertFalse(presenterMock.updateViewWasCalled)
    }
    
    func test_handleConfirmButtonTap_shouldSucced() {
        guard let coordinatorMock ,
              let presenterMock,
              let workerMock else {
            XCTFail("Mocks not initialized")
            return
        }
        
        let id = "12345678"
        sut?.handleConfirmButtonTap(id: id)
        
        
        XCTAssertTrue(coordinatorMock.showLoadingWasCalled)
        XCTAssertTrue(coordinatorMock.removerLoadingWasCalled)
        XCTAssertTrue(workerMock.deleteTeamWasCalled)
        XCTAssertTrue(coordinatorMock.showSuccessMessageWasCalled)
        
        XCTAssertFalse(coordinatorMock.showErrorMessageWasCalled)
        XCTAssertFalse(presenterMock.updateViewWasCalled)
        XCTAssertFalse(presenterMock.updateViewForIdTextFieldErrorStateWasCalled)
        
    }
    
    func test_handleConfirmButtonTap_shouldReturnError() {
        guard let coordinatorMock ,
              let presenterMock,
              let workerMock else {
            XCTFail("Mocks not initialized")
            return
        }
        
        workerMock.deleteTeamShouldSucced = false
        
        let id = "12345678"
        sut?.handleConfirmButtonTap(id: id)
        
        
        XCTAssertTrue(coordinatorMock.showLoadingWasCalled)
        XCTAssertTrue(coordinatorMock.removerLoadingWasCalled)
        XCTAssertTrue(workerMock.deleteTeamWasCalled)
        XCTAssertTrue(coordinatorMock.showErrorMessageWasCalled)
        
        XCTAssertFalse(coordinatorMock.showSuccessMessageWasCalled)
        XCTAssertFalse(presenterMock.updateViewWasCalled)
        XCTAssertFalse(presenterMock.updateViewForIdTextFieldErrorStateWasCalled)
        
    }
    
}
