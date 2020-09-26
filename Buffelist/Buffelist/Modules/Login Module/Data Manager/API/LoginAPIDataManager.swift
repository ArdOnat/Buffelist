//
//  LoginAPIDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 24.09.2020.
//

import Foundation

class LoginAPIDataManager: LoginAPIDataManagerProtocol {
    
    weak var interactor: LoginPresenterToInteractorProtocol?
    
    init(interactor: LoginPresenterToInteractorProtocol) {
        self.interactor = interactor
    }

    func sendLoginRequest(userInfo: String, password: String)  {
        LoginService.login(userInfo: userInfo, password: password) { result, token in
            switch result {
            case .success(let result):
                self.interactor?.onLoginSuccess(result: result, token: token)
            case .failure(let error):
                self.interactor?.onRequestFailure(error: error)
            }
        }
    }
    
    func sendGetResetLinkRequest(userInfo: String)  {
        LoginService.getResetLink(userInfo: userInfo) { result in
            switch result {
            case .success(let result):
                break
                //self.interactor?.onLoginSuccess()
            case .failure(let error):
                self.interactor?.onRequestFailure(error: error)
            }
        }
    }
    
}
