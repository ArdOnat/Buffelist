//
//  RegisterPresenter.swift
//  Buffelist
//
//  Created by Arda Onat on 27.09.2020.
//

class RegisterPresenter {
    
    weak var view: RegisterPresenterToViewProtocol?
    var interactor: RegisterPresenterToInteractorProtocol?
    var router: RegisterWireframeProtocol?
    
    init( view: RegisterPresenterToViewProtocol, interactor: RegisterPresenterToInteractorProtocol, router: RegisterWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension RegisterPresenter: RegisterViewToPresenterProtocol {
    
    func register(username: String, email: String, password: String) {
        interactor?.sendRegisterRequest(username: username, email: email, password: password)
    }

}

extension RegisterPresenter: RegisterInteractorToPresenterProtocol {
    
    func onRegisterSuccess() {
        
    }
    
    func onRequestFailure(error: Error) {
        //view?.onLoginFailure()
    }
    
}
