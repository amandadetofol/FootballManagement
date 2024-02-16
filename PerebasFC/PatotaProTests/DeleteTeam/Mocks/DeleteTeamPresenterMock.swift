//
//  DeleteTeamPresenterMock.swift
//  PatotaProTests
//
//  Created by Amanda Detofol on 16/02/24.
//

@testable import PatotaPro

final class DeleteTeamPresenterMock: DeleteTeamPresenterProtocol {
    
    var updateViewWasCalled = false
    var updateViewForIdTextFieldErrorStateWasCalled = false
     
    func updateView() {
        updateViewWasCalled = true
    }
    
    func updateViewForIdTextFieldErrorState() {
        updateViewForIdTextFieldErrorStateWasCalled  = true 
    }
    
}
