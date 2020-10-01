//
//  BuffelistButton.swift
//  Buffelist
//
//  Created by Arda Onat on 1.10.2020.
//

import UIKit

enum BuffelistButtonStyle {
    case turquoiseBackgroundWhiteText
    case redTitleBorderless
    case grayTextGrayBorder
    case redBackgroundWhiteText
    case clearWhiteTextYellowBorder
}

class BuffelistButton: UIButton {

    var style: BuffelistButtonStyle? {
        didSet {
            commonInit(style: style)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        titleLabel?.font = UIFont(name: "Avenir-Black", size: 16.0)
    }
    
    private func commonInit(style: BuffelistButtonStyle? = .turquoiseBackgroundWhiteText) {
        switch style {
        case .turquoiseBackgroundWhiteText:
            cornerRadius = 19
            
            titleLabel?.font = UIFont(name: "Muli-Bold", size: 18.4)
            setTitleColor(UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0), for: .normal)
            
            backgroundColor = UIColor(red: 79/255, green: 170/255, blue: 160/255, alpha: 1.0)
        case .redTitleBorderless:
            borderWidth = 0
            
            titleLabel?.font = UIFont(name: "Muli-Bold", size: 18.4)
            setTitleColor(UIColor(red: 197/255, green: 23/255, blue: 34/255, alpha: 1.0), for: .normal)
            
            backgroundColor = .clear
        case .grayTextGrayBorder:
            cornerRadius = 19
            
            
            borderWidth = 1.2
            borderColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 1.0)
            
            setTitleColor(UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 1.0), for: .normal)
            
            backgroundColor = .clear
        case .redBackgroundWhiteText:
            cornerRadius = 19
            
            setTitleColor(UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0), for: .normal)
            
            backgroundColor = UIColor(red: 197/255, green: 23/255, blue: 34/255, alpha: 1.0)
        case .clearWhiteTextYellowBorder:
            break
        case .none:
            break
        }
    }
    
    func updateTitleAndImage(title: String, image: UIImage? = nil) {
        setTitle(title, for: .normal)
        if let image = image {
            setImage(image, for: .normal)
        }
        else {
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func setStatus(isEnabled: Bool) {
        alpha = isEnabled ? 1.0 : 0.5
        self.isEnabled = isEnabled
    }

}
