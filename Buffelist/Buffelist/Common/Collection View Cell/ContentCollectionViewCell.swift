//
//  ContentCollectionViewCell.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import UIKit

protocol ContentCellActionHandler {
    func deletePressed(sender: UIButton)
    func linkDirectionButtonPressed(sender: UIButton)
}

protocol PeopleCellActionHandler {
    func linkDirectionButtonPressed(sender: UIButton)
}

class ContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var linkDirectionButton: UIButton!
    
    var contentCellActionHandler: ContentCellActionHandler?
    var peopleCellActionHandler: PeopleCellActionHandler?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = UIImage()
        nameLabel.text = ""
        dateLabel.text = ""
    }
    
    func configure() {
        itemImageView = nil
        nameLabel.text = "a"
        dateLabel.text = "a"
    }
    
    func configureWithDelete(itemInformation: ContentModel) {
        itemImageView.downloaded(from: itemInformation.imageUrl)
        nameLabel.text = "\(itemInformation.title)"
        dateLabel.text = "\(itemInformation.createdAt.date)"
        
        deleteImage.isHidden = false
        deleteButton.isHidden = false
        deleteButton.isEnabled = true
    }
    
    func configureWithoutDelete(itemInformation: ContentModel) {
        itemImageView.downloaded(from: itemInformation.imageUrl)
        nameLabel.text = "\(itemInformation.title)"
        dateLabel.text = "\(itemInformation.createdAt.date)"
        
        deleteImage.isHidden = true
        deleteButton.isHidden = true
        deleteButton.isEnabled = false
    }
    
    func configureWithUser(peopleInformation: SearchUserResult) {
        
        if let profilePhotoURL = peopleInformation.profilePhotoURL {
            itemImageView.downloaded(from: profilePhotoURL)
        }
        else {
            itemImageView.image = UIImage(named: "astronaut")
        }
        
        nameLabel.text = "\(peopleInformation.firstName?.uppercased() ?? peopleInformation.username.uppercased()) \(peopleInformation.lastName?.uppercased() ?? "")"
        dateLabel.text = "\(peopleInformation.biography ?? "")"
        
        deleteImage.isHidden = true
        deleteButton.isHidden = true
        deleteButton.isEnabled = false
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        contentCellActionHandler?.deletePressed(sender: sender)
    }
    
    @IBAction func linkDirectionButtonPressed(_ sender: UIButton) {
        contentCellActionHandler?.linkDirectionButtonPressed(sender: sender)
        peopleCellActionHandler?.linkDirectionButtonPressed(sender: sender)
    }
    
}
