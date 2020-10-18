//
//  SearchPeopleView.swift
//  Buffelist
//
//  Created by Arda Onat on 18.10.2020.
//

import UIKit


internal protocol SearchPeopleViewActionHandler {
    func searchButtonClicked(searchText: String)
}

class SearchPeopleView: UIView, NibOwnerLoadable, UISearchBarDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchPeopleViewActionHandler: SearchPeopleViewActionHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        loadNibContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        loadNibContent()
        
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
    }
    
    private func configure() {
    }
    
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        searchPeopleViewActionHandler?.searchButtonClicked(searchText: searchBar.text ?? "")
    }
    
}
