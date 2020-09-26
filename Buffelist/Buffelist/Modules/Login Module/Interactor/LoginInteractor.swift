//
//  LoginInteractor.swift
//  Buffelist
//
//  Created by Arda Onat on 24.09.2020.
//

class LoginInteractor {

    weak var presenter: LoginInteractorToPresenterProtocol?
    var APIDataManager: LoginAPIDataManagerProtocol?
    
    init() {
        self.APIDataManager = LoginAPIDataManager(interactor: self)
    }
    
}

extension LoginInteractor: LoginPresenterToInteractorProtocol {
    
    func sendLoginRequest(userInfo: String, password: String) {
        APIDataManager?.sendLoginRequest(userInfo: userInfo , password: password)
    }
    
    func sendGetResetLinkRequest(userInfo: String) {
        APIDataManager?.sendGetResetLinkRequest(userInfo: userInfo)
    }
    
    func onLoginSuccess(result: LoginResult, token: String) {
        // add user to Realm
        self.presenter?.onLoginSuccess()
    }
    
    func onRequestFailure(error: Error) {
        self.presenter?.onRequestFailure(error: error)
    }
    
}
