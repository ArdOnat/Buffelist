//
//  ProfileBottomView.swift
//  Buffelist
//
//  Created by Arda Onat on 24.10.2020.
//

import UIKit


protocol ProfileBottomHandler {
    func logoutButtonPressed()
}

class ProfileBottomView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var logoutButton: BuffelistButton!
    
    var profileBottomHandler: ProfileBottomHandler?
    
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
    
    func configurePage() {
        if UserProvider.users().count != 0 {
            configure()
        }
        else {
            configureEmpty()
        }
    }
    
    private func configure() {
        logoutButton.isHidden = false
        logoutButton.isEnabled = true
    }
    
    private func configureEmpty() {
        logoutButton.isHidden = true
        logoutButton.isEnabled = false
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        profileBottomHandler?.logoutButtonPressed()
    }
}
