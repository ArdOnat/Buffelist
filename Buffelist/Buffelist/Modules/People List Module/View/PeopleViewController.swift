//
//  PeopleViewController.swift
//  Buffelist
//
//  Created by Arda Onat on 10.10.2020.
//

import UIKit

class PeopleViewController: UIViewController, PeopleCellActionHandler {

    var presenter: PeopleListViewToPresenterProtocol?
    
    private var keyboardHandler: KeyboardHandler!
    var subPeopleView: PeopleView!
    var vSpinner : UIView?
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    var peopleList = [SearchUserResult]()
    var username: String = ""
    var isSearched: Bool = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subPeopleView.informationLabel.text = "Here you will see people that you follow"
        navigationItem.leftBarButtonItem = nil
        
        getFollowingsOfUser(username: username)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupUIFunctionality()
        configureKeyboardHandler()
        setupDelegation()
        getFollowingsOfUser(username: UserProvider.user().username)
    }
    
    private func setupUI() {
        subPeopleView = view  as? PeopleView
        
        subPeopleView.collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ContentCollectionViewCell")
        subPeopleView.collectionView.allowsSelection = false
    }
    
    @objc func reloadView() {
        viewWillAppear(true)
    }
    
    private func setupUIFunctionality() {
        
    }
    
    private func configureKeyboardHandler() {
        keyboardHandler = KeyboardHandler(with: subPeopleView.scrollView, responders: [subPeopleView.scrollView.subviews.first!])
    }
    
    private func setupDelegation() {
        subPeopleView.searchBar.delegate = self
        
        subPeopleView.collectionView.delegate = self
        subPeopleView.collectionView.dataSource = self
    }
    
    func linkDirectionButtonPressed(sender: UIButton) {
        presenter?.navigateToUserProfile(username: peopleList[sender.tag].username)
    }

}

extension PeopleViewController: PeopleListPresenterToViewProtocol {
    
    // MARK: - Get Followings Of User Service
    
    func getFollowingsOfUser(username: String) {
        activityIndicator.startAnimating()
        presenter?.getFollowingsOfUser(username: username)
    }
    
    func onGetFollowingsOfUserSuccess(peopleList: [SearchUserResult]) {
        self.activityIndicator.stopAnimating()
        self.peopleList = peopleList
        DispatchQueue.main.async {
            self.subPeopleView.collectionView.reloadData()
        }
    }
    
    func onGetFollowingsOfUserFailure(error: String) {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Get Followings Of User Service

    func searchUser(username: String) {
        activityIndicator.startAnimating()
        presenter?.searchUser(username: username)
    }
    
    func onSearchUserSuccess(peopleList: [SearchUserResult]) {
        self.subPeopleView.informationLabel.text = "Search Result"
        self.isSearched = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Return To Follows", style: .plain, target: nil, action: #selector(self.reloadView))
        
        self.activityIndicator.stopAnimating()
        self.peopleList = peopleList
        DispatchQueue.main.async {
            self.subPeopleView.collectionView.reloadData()
        }
    }
    
    func onSearchUserFailure(error: String) {
        self.activityIndicator.stopAnimating()
    }
    
}

extension PeopleViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        searchUser(username: searchBar.text ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}

extension PeopleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peopleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
        
        cell.configureWithUser(peopleInformation: peopleList[indexPath.row])
        cell.peopleCellActionHandler = self
        cell.linkDirectionButton.tag = indexPath.row
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3.0
        return cell
    }
    
}
