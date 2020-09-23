//
//  HomePresenter.swift
//  Buffelist
//
//  Created by Arda Onat on 23.09.2020.
//

class HomePresenter {
    
    weak var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomeWireframeProtocol?
    
    init( view: HomePresenterToViewProtocol, interactor: HomePresenterToInteractorProtocol, router: HomeWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension HomePresenter: HomeViewToPresenterProtocol {
    
    func navigateToPlatform() {
        if let view = view {
            router?.navigateToPlatform(view: view)
        }
    }
    
    func navigateToLogin() {
        if let view = view {
            router?.navigateToLogin(view: view)
        }
    }
    
    func navigateToRegister() {
        if let view = view {
            router?.navigateToRegister(view: view)
        }
    }
    
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    
}

