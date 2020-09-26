//
//  LoginLocalDataManager.swift
//  Buffelist
//
//  Created by Arda Onat on 26.09.2020.
//

import Foundation

class LoginLocalDataManager {
    
    weak var interactor: LoginPresenterToInteractorProtocol?
    
    init(interactor: LoginPresenterToInteractorProtocol) {
        self.interactor = interactor
    }
    
}
