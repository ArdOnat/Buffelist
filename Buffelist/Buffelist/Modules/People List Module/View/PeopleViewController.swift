//
//  PeopleViewController.swift
//  Buffelist
//
//  Created by Arda Onat on 10.10.2020.
//

import UIKit

class PeopleViewController: UIViewController, PeopleCellActionHandler, OnTapKeyboardHideable, SearchPeopleViewActionHandler {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var followingsView: FollowingsView!
    @IBOutlet weak var searchPeopleView: SearchPeopleView!
    
    var presenter: PeopleListViewToPresenterProtocol?
    
    private var keyboardHandler: KeyboardHandler!
    var subSearchPeopleView: SearchPeopleView!
    var subFollowingsView: FollowingsView!
    var vSpinner : UIView?
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    var peopleList = [SearchUserResult]()
    var username: String = ""
    var isSearched: Bool = false

    var viewController: UIViewController? {
        return self
    }
    
    init() {
        super.init(nibName: "PeopleView", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupUIFunctionality()
        configureKeyboardHandler()
        setupDelegation()
        setupHideKeyboardOnTapRecognizer()
        getFollowingsOfUser(username: UserProvider.user().username)
    }
    
    private func setupUI() {

        navigationController?.navigationBar.isHidden = true
        
        segmentedControl.addTarget(self, action: #selector(self.segmentedControlValueChanged), for: .valueChanged)
        
        followingsView.collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ContentCollectionViewCell")
        followingsView.collectionView.allowsSelection = false
        
        searchPeopleView.collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ContentCollectionViewCell")
        searchPeopleView.collectionView.allowsSelection = false
        
        followingsView.isHidden = false
        searchPeopleView.isHidden = true
        
        segmentedControl.selectedSegmentIndex = 0
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupUIFunctionality() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        followingsView.collectionView.refreshControl = refreshControl
    }
    
    private func configureKeyboardHandler() {
        keyboardHandler = KeyboardHandler(with: searchPeopleView.scrollView, responders: [searchPeopleView.subviews.first!])
    }
    
    private func setupDelegation() {
        followingsView.collectionView.delegate = self
        followingsView.collectionView.dataSource = self
        
        searchPeopleView.collectionView.delegate = self
        searchPeopleView.collectionView.dataSource = self
        
        searchPeopleView.searchPeopleViewActionHandler = self
    }
    
    func linkDirectionButtonPressed(sender: UIButton) {
        presenter?.navigateToUserProfile(username: peopleList[sender.tag].username, photoURL: peopleList[sender.tag].profilePhotoURL ?? "")
    }
    
    @objc func pullToRefresh() {
        getFollowingsOfUser(username: UserProvider.user().username)
    }
    
    @objc func segmentedControlValueChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            followingsView.isHidden = false
            searchPeopleView.isHidden = true
            getFollowingsOfUser(username: UserProvider.user().username)
        }
        else {
            followingsView.isHidden = true
            searchPeopleView.isHidden = false
            searchUser(username: searchPeopleView.searchBar.text ?? "")
        }
    }
    
    func searchButtonClicked(searchText: String) {
        searchUser(username: searchText)
    }

}

extension PeopleViewController: PeopleListPresenterToViewProtocol {
    
    // MARK: - Get Followings Of User Service
    
    func getFollowingsOfUser(username: String) {
        presenter?.getFollowingsOfUser(username: username)
    }
    
    func onGetFollowingsOfUserSuccess(peopleList: [SearchUserResult]) {
        activityIndicator.stopAnimating()
        
        self.peopleList = peopleList
        DispatchQueue.main.async {
            self.followingsView.collectionView.reloadData()
            self.followingsView.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    func onGetFollowingsOfUserFailure(error: String) {
        DispatchQueue.main.async {
            self.followingsView.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Get Followings Of User Service

    func searchUser(username: String) {
        activityIndicator.startAnimating()
        presenter?.searchUser(username: username)
    }
    
    func onSearchUserSuccess(peopleList: [SearchUserResult]) {
        self.activityIndicator.stopAnimating()

        self.peopleList = peopleList
        
        DispatchQueue.main.async {
            self.searchPeopleView.collectionView.reloadData()
        }
    }
    
    func onSearchUserFailure(error: String) {
        self.activityIndicator.stopAnimating()
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
