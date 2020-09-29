//
//  RegisterViewController.swift
//  Buffelist
//
//  Created by Arda Onat on 27.09.2020.
//

import UIKit

class RegisterViewController: UIViewController {

    var presenter: RegisterViewToPresenterProtocol?
    
    var subRegisterView: RegisterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUIFunctionality()
    }
    
    private func setupUIFunctionality() {
        subRegisterView = view  as? RegisterView
        
        subRegisterView.continueButton.addTarget(self, action: #selector(self.continueButtonPressed), for: .touchUpInside)
    }
    

}

extension RegisterViewController: RegisterViewUserActionHandler {
    
    @objc func continueButtonPressed() {
        presenter?.register(username: subRegisterView.usernameTextField.text!, email: subRegisterView.emailTextField.text! , password: subRegisterView.passwordTextField.text! )
    }
    
}

extension RegisterViewController: RegisterPresenterToViewProtocol {
    
}
