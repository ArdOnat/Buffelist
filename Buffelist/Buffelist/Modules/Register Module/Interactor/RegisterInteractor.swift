//
//  RegisterInteractor.swift
//  Buffelist
//
//  Created by Arda Onat on 27.09.2020.
//

class RegisterInteractor {

    weak var presenter: RegisterInteractorToPresenterProtocol?
    var APIDataManager: RegisterAPIDataManagerProtocol?
    
    init() {
        self.APIDataManager = RegisterAPIDataManager(interactor: self)
    }
    
}

extension RegisterInteractor: RegisterPresenterToInteractorProtocol {
    
    func sendRegisterRequest(username: String, email: String, password: String) {
        APIDataManager?.sendRegisterRequest(username: username, email: email, password: password)
    }
    
    func onRegisterSuccess() {
        // add user to Realm
        self.presenter?.onRegisterSuccess()
    }
    
    func onRequestFailure(error: Error) {
        self.presenter?.onRequestFailure(error: error)
    }
    
}
