//
//  DeleTeamCoordinatorMock.swift
//  PatotaProTests
//
//  Created by Amanda Detofol on 16/02/24.
//

@testable import PatotaPro

final class DeleTeamCoordinatorMock: DeleteTeamCoordinatorProtocol {
    
    var showErrorMessageWasCalled = false
    var showSuccessMessageWasCalled = false
    var showLoadingWasCalled = false
    var removerLoadingWasCalled = false
    
    func showErrorMessage(){
        showErrorMessageWasCalled = true
    }
    
    func showSuccessMessage(){
        showSuccessMessageWasCalled = true
    }
    
    func showLoading(){
        showLoadingWasCalled =  true
    }
    
    func removerLoading(){
        removerLoadingWasCalled = true
    }
    
}
