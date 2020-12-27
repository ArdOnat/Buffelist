//
//  ProfileInformationView.swift
//  Buffelist
//
//  Created by Arda Onat on 24.10.2020.
//

import UIKit

protocol SetUserInfoDelegate {
    func setUserInfo(isActive: Bool)
}

class ProfileInformationView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var pageStackView: UIStackView!
    @IBOutlet weak var usernameStackView: UIStackView!
    @IBOutlet weak var nameStackView: UIStackView!
    @IBOutlet weak var surnameStackView: UIStackView!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var personalInfoTitleLabel: UILabel!
    @IBOutlet weak var changePasswordButton: BuffelistButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var passwordBackgroundView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var changePasswordView: UIView!
    
    private var usernameHandler: TextFieldHandler?
    private var nameHandler: TextFieldHandler?
    private var surnameHandler: TextFieldHandler?
    private var titleHandler: TextFieldHandler?
    
    var setUserInfoDelegate: SetUserInfoDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        
        configurePage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
        
        configurePage()
    }
    
    private func prepareTextFieldHandlers(){
        usernameHandler = TextFieldHandler(with: usernameTextField)
        usernameHandler?.onTextDidChange = { [weak self] _ in
            if self?.nameTextField.text?.count ?? 0 > 0 && self?.surnameTextField.text?.count ?? 0 > 0{
                self?.setUserInfoDelegate?.setUserInfo(isActive: true)
            }
            else {
                self?.setUserInfoDelegate?.setUserInfo(isActive: false)
            }
        }
        usernameHandler?.onReturn = { [weak self] in
            _ = self?.nameTextField.becomeFirstResponder()
        }
        
        nameHandler = TextFieldHandler(with: nameTextField)
        nameHandler?.onTextDidChange = { [weak self] _ in
            if self?.nameTextField.text?.count ?? 0 > 0 && self?.surnameTextField.text?.count ?? 0 > 0{
                self?.setUserInfoDelegate?.setUserInfo(isActive: true)
            }
            else {
                self?.setUserInfoDelegate?.setUserInfo(isActive: false)
            }
        }
        nameHandler?.onReturn = { [weak self] in
            _ = self?.surnameTextField.becomeFirstResponder()
        }
        
        surnameHandler = TextFieldHandler(with: surnameTextField)
        surnameHandler?.onTextDidChange = { [weak self] _ in
            if self?.nameTextField.text?.count ?? 0 > 0 && self?.surnameTextField.text?.count ?? 0 > 0 {
                self?.setUserInfoDelegate?.setUserInfo(isActive: true)
            }
            else {
                self?.setUserInfoDelegate?.setUserInfo(isActive: false)
            }
        }
        surnameHandler?.onReturn = { [weak self] in
           _ = self?.titleLabel.becomeFirstResponder()
        }
        
        titleHandler = TextFieldHandler(with: titleTextField)
        titleHandler?.onTextDidChange = { [weak self] _ in
            if self?.nameTextField.text?.count ?? 0 > 0 && self?.surnameTextField.text?.count ?? 0 > 0 {
                
            }
            else {
                self?.setUserInfoDelegate?.setUserInfo(isActive: false)
            }
        }
        titleHandler?.onReturn = { [weak self] in
            
        }
        
    }
    
    private func configure() {
        usernameTextField.text = UserProvider.user().username
        nameTextField.text = UserProvider.user().firstName
        surnameTextField.text = UserProvider.user().lastName
        titleTextField.text = UserProvider.user().biography
    
        usernameTextField.isHidden = false
        nameTextField.isHidden = false
        surnameTextField.isHidden = false
        titleTextField.isHidden = false
        
        prepareTextFieldHandlers()
        
        changePasswordButton.isHidden = false
        changePasswordButton.isEnabled = true
        changePasswordView.isHidden = false
    }
    
    private func configureEmpty() {
        usernameTextField.text = ""
        nameTextField.text = ""
        surnameTextField.text = ""
        titleTextField.text = ""
        
        usernameTextField.isHidden = true
        nameTextField.isHidden = true
        surnameTextField.isHidden = true
        titleTextField.isHidden = true
        
        changePasswordButton.isHidden = true
        changePasswordButton.isEnabled = false
        changePasswordView.isHidden = true
    }
    
    func configurePage() {
        if UserProvider.users().count != 0 {
            configure()
        }
        else {
            configureEmpty()
        }
    }
    
    @IBAction func changePasswordButtonPressed(_ sender: Any) {
        
    }
}
