//
//  HomeView.swift
//  Buffelist
//
//  Created by Arda Onat on 23.09.2020.
//

import UIKit

class HomeView: UIView {
    
    @IBOutlet weak var homePageImageView: UIImageView!
    @IBOutlet weak var platformButton: BuffelistButton!
    @IBOutlet weak var loginButton: BuffelistButton!
    @IBOutlet weak var registerButton: BuffelistButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        // TODO: Localization
    }
}
