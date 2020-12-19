//
//  TextFieldHandler.swift
//  Buffelist
//
//  Created by Arda Onat on 24.10.2020.
//
import Foundation
import UIKit

class TextFieldHandler: NSObject, UITextFieldDelegate {
    
    var maxLength: Int?
    var prefix: String?
    var editable = true
    
    private var textField: UITextField
    
    init(with textField: UITextField) {
        self.textField = textField
        super.init()
        self.textField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange), name: UITextField.textDidChangeNotification, object: textField)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func textFieldTextDidChange() {
        onTextDidChange?(textField.text)
    }
    
    var onTextDidChange: ((_ text: String?)->())?
    var onDidBeginEditing: (()->())?
    var onDidEndEditing: (()->())?
    var onReturn: (()->())?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let prefix = prefix, let text = textField.text, text.count == 0 {
            textField.text = prefix
        }
        
        onDidBeginEditing?()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onDidEndEditing?()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard string != "\n" else {
            onReturn?()
            return true
        }
        
        guard editable else {
            return false
        }
        
        var result = true
        
        if let maxLength = maxLength, string.count > 0 {
            result = result && textField.text?.count ?? 0 < maxLength
        }
        
        if let prefix = prefix {
            result = result && ((string.count > 0 && (range.location + range.length) >= prefix.count) || (string.count == 0 && (range.location + range.length) > prefix.count))
        }
        
        return result
    }
}
