//
//  ContentCollectionViewCell.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import UIKit

protocol DeleteHandler {
    func deletePressed(sender: UIButton)
}

class ContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var handler: DeleteHandler?
    
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
        dateLabel.text = "\(itemInformation.createdAt.epochSecond)"
        
        deleteImage.isHidden = false
        deleteButton.isHidden = false
        deleteButton.isEnabled = true
    }
    
    func configureWithoutDelete(itemInformation: ContentModel) {
        itemImageView.downloaded(from: itemInformation.imageUrl)
        nameLabel.text = "\(itemInformation.title)"
        dateLabel.text = "\(itemInformation.createdAt.epochSecond)"
        
        deleteImage.isHidden = true
        deleteButton.isHidden = true
        deleteButton.isEnabled = false
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        handler?.deletePressed(sender: sender)
    }
    
}
