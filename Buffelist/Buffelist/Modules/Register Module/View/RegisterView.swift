//
//  RegisterView.swift
//  Buffelist
//
//  Created by Arda Onat on 27.09.2020.
//

import UIKit
import SkyFloatingLabelTextField
class RegisterView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var usernameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordAgainTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var continueButton: BuffelistButton!
    
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
    
}
