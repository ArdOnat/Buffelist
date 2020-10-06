//
//  LoginInteractor.swift
//  Buffelist
//
//  Created by Arda Onat on 24.09.2020.
//

class LoginInteractor {

    weak var presenter: LoginInteractorToPresenterProtocol?
    var APIDataManager: LoginAPIDataManagerProtocol?
    var LocalDataManager: LoginLocalDataManagerProtocol?

    init() {
        self.APIDataManager = LoginAPIDataManager(interactor: self)
        self.LocalDataManager = LoginLocalDataManager(interactor: self)
    }
    
}

extension LoginInteractor: LoginPresenterToInteractorProtocol {
    
    func sendLoginRequest(userInfo: String, password: String) {
        APIDataManager?.sendLoginRequest(userInfo: userInfo , password: password)
    }
    
    func sendGetResetLinkRequest(userInfo: String) {
        APIDataManager?.sendGetResetLinkRequest(userInfo: userInfo)
    }
    
    func onLoginSuccess(result: LoginResult, token: String, password: String) {
        self.presenter?.onLoginSuccess(result: result, token: token, password: password)
    }
    
    func onRequestFailure(error: Error) {
        self.presenter?.onRequestFailure(error: error)
    }
    
    func createUser(result: LoginResult, token: String, password: String) {
        self.LocalDataManager?.createUser(result: result, password: password, token: token) {
            self.presenter?.onUserCreated()
        }
    }
    
}
