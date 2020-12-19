//
//  LoginPresenter.swift
//  Buffelist
//
//  Created by Arda Onat on 24.09.2020.
//

import Foundation

class LoginPresenter {
    
    weak var view: LoginPresenterToViewProtocol?
    var interactor: LoginPresenterToInteractorProtocol?
    var router: LoginWireframeProtocol?
    
    init( view: LoginPresenterToViewProtocol, interactor: LoginPresenterToInteractorProtocol, router: LoginWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension LoginPresenter: LoginViewToPresenterProtocol {
    
    func login(userInfo: String, password: String) {
        interactor?.sendLoginRequest(userInfo: userInfo, password: password)
    }
    
    func getResetLink(userInfo: String) {
        interactor?.sendGetResetLinkRequest(userInfo: userInfo)
    }

}

extension LoginPresenter: LoginInteractorToPresenterProtocol {
    
    func onLoginSuccess(result: LoginResult, token: String, password: String) {
        
        interactor?.createUser(result: result, token: token, password:password)
    }
    
    func onRequestFailure(error: Error) {
        //view?.onLoginFailure()
    }
    
    func onUserCreated() {
        if let view = view {
            router?.navigateToPeople(view: view)
        }
        NotificationCenter.default.post(name: .didAuthenticationStatusChanged, object: nil)
    }
    
}
