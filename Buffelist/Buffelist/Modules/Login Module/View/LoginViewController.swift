//
//  LoginViewController.swift
//  Buffelist
//
//  Created by Arda Onat on 22.09.2020.
//

import UIKit
import PopupDialog

class LoginViewController: UIViewController, OnTapKeyboardHideable {

    var presenter: LoginViewToPresenterProtocol?
    
    var subLoginView: LoginView!
    var popup: PopupDialog?
    private var keyboardHandler: KeyboardHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupUIFunctionality()
        configureKeyboardHandler()
        setupHideKeyboardOnTapRecognizer()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        
        subLoginView = view  as? LoginView
        
        subLoginView.usernameTextField.placeholder = "Email or Username"
        subLoginView.passwordTextField.placeholder = "Password"
        
        subLoginView.forgotPasswordButton.style = .redBackgroundWhiteText
        subLoginView.loginButton.style = .redBackgroundWhiteText
    }
    
    private func setupUIFunctionality() {
        subLoginView.forgotPasswordButton.addTarget(self, action: #selector(self.forgotPasswordButtonPressed), for: .touchUpInside)
        
        subLoginView.loginButton.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)
    }
    
    private func configureKeyboardHandler() {
        keyboardHandler = KeyboardHandler(with: subLoginView.scrollView, responders: [subLoginView.scrollView.subviews.first!])
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
        presenter?.login(userInfo: subLoginView.usernameTextField.text!, password: subLoginView.passwordTextField.text!)
    }
    
}

extension LoginViewController: LoginPresenterToViewProtocol {
    
}
