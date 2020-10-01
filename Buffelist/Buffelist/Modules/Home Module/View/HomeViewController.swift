//
//  HomeViewController.swift
//  Buffelist
//
//  Created by Arda Onat on 23.09.2020.
//

import UIKit

class HomeViewController: UIViewController {

    var presenter: HomeViewToPresenterProtocol?
    
    var subHomeView: HomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupUIFunctionality()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        
        subHomeView = view  as? HomeView
        
        subHomeView.platformButton.style = .redBackgroundWhiteText
        
        subHomeView.loginButton.style = .redBackgroundWhiteText
        
        subHomeView.registerButton.style = .redBackgroundWhiteText
        
    }
    
    private func setupUIFunctionality() {
        
        subHomeView.platformButton.addTarget(self, action: #selector(self.platformButtonPressed), for: .touchUpInside)
        
        subHomeView.loginButton.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)
        
        subHomeView.registerButton.addTarget(self, action: #selector(self.registerButtonPressed), for: .touchUpInside)
    }
    
}

extension HomeViewController: HomeViewUserActionHandler {
    
    @objc func platformButtonPressed() {
        presenter?.navigateToPlatform()
    }
    
    @objc func loginButtonPressed() {
        presenter?.navigateToLogin()
    }
    
    @objc func registerButtonPressed() {
        presenter?.navigateToRegister()
    }
    
}

extension HomeViewController: HomePresenterToViewProtocol {
    
}
