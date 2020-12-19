//
//  PopupView.swift
//  Buffelist
//
//  Created by Arda Onat on 26.09.2020.
//

import UIKit

class PopupViewController: UIViewController {
    
    var subPopupView: PopupView!
    var alertContent: AlertContentConfig? {
        didSet {
            self.viewDidLoad()
            configurePopup(popupType: alertContent?.popupType ?? .oneButton)
        }
    }
    
    var didTapUpButton: ((String?) -> Void)?
    var didTapDownButton: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIFunctionality()
    }
    
    private func setupUIFunctionality() {
        subPopupView = view  as? PopupView
        
        subPopupView.upButton.addTarget(self, action: #selector(self.upButtonPressed), for: .touchUpInside)
        
        subPopupView.downButton.addTarget(self, action: #selector(self.downButtonPressed), for: .touchUpInside)
    }
    
    @objc func upButtonPressed() {
        didTapUpButton?(subPopupView.popupInformationTextField.text)
    }
    
    @objc func downButtonPressed() {
        didTapDownButton?()
    }
    
    private func configurePopup(popupType: PopupType) {
        subPopupView.popupInformationLabel.text = alertContent?.alertInformationText
        subPopupView.upButton.setTitle(alertContent?.alertUpButtonTitle, for: .normal)
        subPopupView.downButton.setTitle(alertContent?.alertDownButtonTitle, for: .normal)
        
        subPopupView.upButton.style = .redBackgroundWhiteTextNoRadius
        subPopupView.downButton.style = .redBackgroundWhiteTextNoRadius
        
        switch popupType {
        case .oneButton:
            subPopupView.popupInformationLabel.isHidden = false
            subPopupView.popupInformationTextField.isHidden = false
            subPopupView.upButton.isHidden = false
            subPopupView.downButton.isHidden = true
        case .twoButton:
            subPopupView.popupInformationLabel.isHidden = false
            subPopupView.popupInformationTextField.isHidden = false
            subPopupView.upButton.isHidden = false
            subPopupView.downButton.isHidden = false
        case .twoButtonNotextField:
            subPopupView.popupInformationLabel.isHidden = false
            subPopupView.popupInformationTextField.isHidden = true
            subPopupView.upButton.isHidden = false
            subPopupView.downButton.isHidden = false
        case .textFieldOneButton:
            subPopupView.popupInformationLabel.isHidden = false
            subPopupView.popupInformationTextField.isHidden = false
            subPopupView.upButton.isHidden = false
            subPopupView.downButton.isHidden = true
        }
    }
    
}
