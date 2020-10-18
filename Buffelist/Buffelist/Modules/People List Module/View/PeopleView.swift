//
//  PeopleView.swift
//  Buffelist
//
//  Created by Arda Onat on 10.10.2020.
//

import UIKit

class PeopleView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var returnToFollowsButton: BuffelistButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        //TODO: set localization ? found nil iboutlet
    }
    
}
