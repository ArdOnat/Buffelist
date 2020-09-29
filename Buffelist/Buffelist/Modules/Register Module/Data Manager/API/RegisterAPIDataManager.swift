//
//  RegisterAPIDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 27.09.2020.
//

import Foundation

class RegisterAPIDataManager: RegisterAPIDataManagerProtocol {
    
    weak var interactor: RegisterPresenterToInteractorProtocol?
    
    init(interactor: RegisterPresenterToInteractorProtocol) {
        self.interactor = interactor
    }

    func sendRegisterRequest(username: String, email: String, password: String)  {
        RegisterService.register(username: username, email: email, password: password) { result in
            switch result {
            case .success(let result):
                self.interactor?.onRegisterSuccess()
            case .failure(let error):
                self.interactor?.onRequestFailure(error: error)
            }
        }
    }
    
}
