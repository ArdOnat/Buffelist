//
//  FollowingsView.swift
//  Buffelist
//
//  Created by Arda Onat on 18.10.2020.
//

import UIKit

class FollowingsView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        loadNibContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        loadNibContent()
    }
    
    private func configure() {
       
    }
    
}
