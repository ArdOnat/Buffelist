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
    private var keyboardHandler: KeyboardHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupUIFunctionality()
        configureKeyboardHandler()
    }
    
    private func setupUI() {
        subRegisterView = view  as? RegisterView
        
        subRegisterView.continueButton.style = .redBackgroundWhiteText
        
        subRegisterView.usernameTextField.placeholder = "Username"
        subRegisterView.emailTextField.placeholder = "Email"
        subRegisterView.passwordTextField.placeholder = "Password"
        subRegisterView.passwordAgainTextField.placeholder = "Password Again"
    }
    
    private func setupUIFunctionality() {
        subRegisterView = view  as? RegisterView
        
        subRegisterView.continueButton.addTarget(self, action: #selector(self.continueButtonPressed), for: .touchUpInside)
    }
    
    private func configureKeyboardHandler() {
        keyboardHandler = KeyboardHandler(with: subRegisterView.scrollView, responders: [subRegisterView.scrollView.subviews.first!])
    }

}

extension RegisterViewController: RegisterViewUserActionHandler {
    
    @objc func continueButtonPressed() {
        presenter?.register(username: subRegisterView.usernameTextField.text!, email: subRegisterView.emailTextField.text! , password: subRegisterView.passwordTextField.text! )
    }
    
}

extension RegisterViewController: RegisterPresenterToViewProtocol {
    
}
