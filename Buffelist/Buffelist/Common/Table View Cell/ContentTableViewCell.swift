//
//  ContentTableViewCell.swift
//  Buffelist
//
//  Created by Arda Onat on 5.10.2020.
//
import UIKit

class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    public let rowHeight = 60
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        dateLabel.text = ""
    }
    
    func configure() {
        nameLabel.text = "a"
        dateLabel.text = "a"
    }
    
    func configure(itemInformation: ContentModel) {
        nameLabel.text = "\(itemInformation.title)"
        dateLabel.text = "\(itemInformation.createdAt.epochSecond)"
    }
    
}
