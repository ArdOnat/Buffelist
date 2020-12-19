//
//  ProfileLocalDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 24.10.2020.
//

import Foundation

class ProfileLocalDataManager: ProfileLocalDataManagerProtocol {
    
    weak var interactor: ProfilePresenterToInteractorProtocol?
    
    init(interactor: ProfilePresenterToInteractorProtocol) {
        self.interactor = interactor
    }
    
    func deleteUserData() {
            do {
            try UserProvider.removeAll()
            interactor?.onLogoutSuccess()
        }
        catch {
            interactor?.onLogoutFailure()
        }
    }
    
}
