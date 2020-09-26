//
//  LoginViewController.swift
//  Buffelist
//
//  Created by Arda Onat on 22.09.2020.
//

import UIKit
import PopupDialog

class LoginViewController: UIViewController {

    var presenter: LoginViewToPresenterProtocol?
    
    var subLoginView: LoginView!
    var popup: PopupDialog?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUIFunctionality()
    }
    
    private func setupUIFunctionality() {
        subLoginView = view  as? LoginView
        
        subLoginView.forgotPasswordButton.addTarget(self, action: #selector(self.forgotPasswordButtonPressed), for: .touchUpInside)
        
        subLoginView.loginButton.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)
    }

}

extension LoginViewController: LoginViewUserActionHandler {
    
    @objc func forgotPasswordButtonPressed() {
        
        let popupVC = PopupViewController()
        popupVC.alertContent = AlertContentConfig( alertInformationText: "Email", alertUpButtonTitle: "Get Reset Link", alertDownButtonTitle: "", popupType: PopupType.textFieldOneButton)
        
        popupVC.didTapUpButton = { text in
            if let text = text {
                self.presenter?.getResetLink(userInfo: text)
            }
        }
        
        popup = PopupDialog(viewController: popupVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, tapGestureDismissal: true, panGestureDismissal: false)
        self.present(popup!, animated: true, completion: nil)
    }
    
    @objc func loginButtonPressed() {
        presenter?.login(userInfo: subLoginView.usernameEmailTextField.text!, password: subLoginView.passwordTextField.text!)
    }
    
}

extension LoginViewController: LoginPresenterToViewProtocol {
    
}
