//
//  MyListView.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation
import SkyFloatingLabelTextField

class MyListView: UIView {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var addItemToListButton: BuffelistButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameTitleLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configure() {
        userImageView.downloaded(from: UserProvider.user().profilePhotoURL)
    }
    
    private func configureNoUser() {
        userImageView.image = UIImage(named: "astronaut")
    }
    
    func configurePage() {
        if UserProvider.users().count != 0 {
            configure()
        }
        else {
            configureNoUser()
        }
        
        collectionView.reloadData()
        tableView.reloadData()
    }
    
}
