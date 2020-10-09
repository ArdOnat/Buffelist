//
//  ContentCollectionViewCell.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteImage: UIImageView!
    
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
    
    func configure(itemInformation: ContentModel) {
        itemImageView.downloaded(from: itemInformation.imageUrl)
        nameLabel.text = "\(itemInformation.title)"
        dateLabel.text = "\(itemInformation.createdAt.epochSecond)"
    }
    
    //func configure
    
}
