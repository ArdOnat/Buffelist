//
//  LoginView.swift
//  Buffelist
//
//  Created by Arda Onat on 22.09.2020.
//

import UIKit

class LoginView: UIView {
    
    @IBOutlet weak var buffeListImageView: UIImageView!
    @IBOutlet weak var loginToAccountLabel: UIStackView!
    @IBOutlet weak var usernameOrEmailLabel: UILabel!
    @IBOutlet weak var usernameEmailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // delegate
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        //TODO: set localization
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
    }
    
}
