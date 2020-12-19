//
//  ProfilePictureView.swift
//  Buffelist
//
//  Created by Arda Onat on 24.10.2020.
//

import UIKit

class ProfilePictureView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var profileEditImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
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
    
    private func configure() {
        usernameLabel.text = UserProvider.user().username
        
        profilePictureImageView.downloaded(from: UserProvider.user().profilePhotoURL)
        
        profilePictureImageView.makeRounded()
        
        profileEditImageView.isHidden = false
    }
    
    private func configureNoUser() {
        profilePictureImageView.makeRounded()
        profilePictureImageView.image = UIImage(named: "astronaut")
        profileEditImageView.isHidden = true
    }
    
    func configurePage() {
        if UserProvider.users().count != 0 {
            configure()
        }
        else {
            configureNoUser()
        }
    }
}

extension UIImageView {

    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
