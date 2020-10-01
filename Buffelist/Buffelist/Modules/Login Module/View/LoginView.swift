//
//  LoginView.swift
//  Buffelist
//
//  Created by Arda Onat on 22.09.2020.
//

import UIKit
import SkyFloatingLabelTextField

class LoginView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buffeListImageView: UIImageView!
    @IBOutlet weak var loginToYourAccountLabel: UILabel!
    @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var forgotPasswordButton: BuffelistButton!
    @IBOutlet weak var loginButton: BuffelistButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        //TODO: set localization ? found nil iboutlet
    }
    
}
