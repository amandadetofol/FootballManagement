//
//  DeleteTeamWorkerMock.swift
//  PatotaProTests
//
//  Created by Amanda Detofol on 16/02/24.
//

@testable import PatotaPro

final class DeleteTeamWorkerMock: DeleteTeamWorkerProtocol {
    
    var deleteTeamWasCalled = false
    var deleteTeamShouldSucced = true
    
    func deleteTeam(
        id: String,
        completion: @escaping ((Bool) -> Void)) {
            deleteTeamWasCalled = true
            completion(deleteTeamShouldSucced)
    }
    
}
