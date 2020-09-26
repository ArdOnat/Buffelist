//
//  PopupView.swift
//  Buffelist
//
//  Created by Arda Onat on 26.09.2020.
//

import UIKit

enum PopupType {
    case oneButton
    case twoButton
    case textFieldOneButton
}

class PopupView: UIView {

    @IBOutlet weak var popupInformationLabel: UILabel!
    @IBOutlet weak var popupInformationTextField: UITextField!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
