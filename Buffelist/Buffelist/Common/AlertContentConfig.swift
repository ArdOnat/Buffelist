//
//  AlertContentConfig.swift
//  Buffelist
//
//  Created by Arda Onat on 26.09.2020.
//

import UIKit

struct AlertContentConfig {
    var alertInformationText = ""
    var alertUpButtonTitle = ""
    var alertDownButtonTitle = ""
    var popupType: PopupType = .oneButton
    
    init(alertInformationText: String, alertUpButtonTitle: String, alertDownButtonTitle: String,
         popupType: PopupType) {
        self.alertInformationText = alertInformationText
        self.alertUpButtonTitle = alertUpButtonTitle
        self.alertDownButtonTitle = alertDownButtonTitle
        self.popupType = popupType
    }
    
    
}
