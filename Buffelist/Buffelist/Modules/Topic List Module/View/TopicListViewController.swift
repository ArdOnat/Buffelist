//
//  TopicListViewController.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation

import PopupDialog

class TopicListViewController: UIViewController, ContentCellActionHandler {
    
    var presenter: TopicListViewToPresenterProtocol?
    
    var subTopicListView: TopicListView!
    var popup: PopupDialog?
    var vSpinner : UIView?
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    var contentList = [ContentModel]()
    var username: String = ""
    var profilePhotoURL: String = ""
    var isFollowing = false
    var contentToDelete: Int = 0
    var isUserPage = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getContentList(username: username)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupUIFunctionality()
        setupDelegation()
    }
    
    private func setupUI() {
        subTopicListView = view  as? TopicListView
        
        navigationController?.navigationBar.isHidden = true
        
        subTopicListView.collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ContentCollectionViewCell")
        subTopicListView.collectionView.allowsSelection = false
        
        subTopicListView.tableView.register(UINib(nibName: "ContentTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ContentTableViewCell")
        subTopicListView.tableView.allowsSelection = false
        
        subTopicListView.segmentedControl.selectedSegmentIndex = 0
        
        if username == "trends" {
            subTopicListView.usernameTitleLabel.text = username.uppercased()
        }
        else {
            subTopicListView.usernameTitleLabel.text = "\(username.uppercased())'S LIST"
        }
        
        isUserPage = false
        
        subTopicListView.userImageView.downloaded(from: profilePhotoURL)
        
        subTopicListView.followButton.isHidden = false
        subTopicListView.followButton.isEnabled = true
        
        if UserProvider.users().count != 0 {
            searchUserByUsername(username: username)
        }
        else {
            subTopicListView.followButton.isHidden = true
            subTopicListView.followButton.isEnabled = false
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupUIFunctionality() {
        subTopicListView.segmentedControl?.addTarget(self, action: #selector(self.segmentedControlChanged(_:)), for: .valueChanged)
        
        subTopicListView.followButton.addTarget(self, action: #selector(self.followButtonPressed), for: .touchUpInside)
        
        if !isUserPage {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
            subTopicListView.collectionView.refreshControl = refreshControl
        }
    }
    
    private func setupDelegation() {
        subTopicListView.collectionView.delegate = self
        subTopicListView.collectionView.dataSource = self
        
        subTopicListView.tableView.delegate = self
        subTopicListView.tableView.dataSource = self
    }
    
    private func updateFollowButton() {
        if isFollowing {
            subTopicListView.followButton.updateTitleAndImage(title: "Unfollow")
            subTopicListView.followButton.style = .redBackgroundWhiteTextNoRadius
        }
        else {
            subTopicListView.followButton.updateTitleAndImage(title: "Follow")
            subTopicListView.followButton.style = .greenBackgroundWhiteText
        }
        
        subTopicListView.followButton.isHidden = false
    }
    
    @objc func pullToRefresh() {
        getContentList(username: username)
    }
}

extension TopicListViewController: TopicListViewUserActionHandler {
    
    @objc func segmentedControlChanged(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            subTopicListView.tableView.isHidden = true
            subTopicListView.collectionView.isHidden = false
        case 1:
            subTopicListView.tableView.isHidden = false
            subTopicListView.collectionView.isHidden = true
        default:
            break
        }
    }
    
    @objc func followButtonPressed() {
        if isFollowing {
            unfollowUser(username: username)
        }
        else {
            followUser(username: username)
        }
    }
    
    func linkDirectionButtonPressed(sender: UIButton) {
        if let url = URL(string: contentList[sender.tag].url) {
            UIApplication.shared.open(url)
        }
    }
    
}

extension TopicListViewController: TopicListPresenterToViewProtocol {
 
    // MARK: - Get Content List Service
    
    func getContentList(username: String) {
        presenter?.getContentList(username: username)
    }
    
    func onGetContentListSuccess(contentList: [ContentModel]) {
        self.contentList = contentList
        DispatchQueue.main.async {
            self.subTopicListView.collectionView.reloadData()
            self.subTopicListView.tableView.reloadData()
            self.subTopicListView.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    func onGetContentListFailure(error: String) {
        DispatchQueue.main.async {
            self.subTopicListView.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Search User By Username Service
    
    func searchUserByUsername(username: String) {
        presenter?.searchUserByUsername(username: username)
    }
    
    func onSearchUserByUsernameSuccess(result: SearchUserResult) {
        activityIndicator.stopAnimating()
        
        isFollowing = result.isUserFollowing ?? false
        
        updateFollowButton()
    }
    
    func onSearchUserByUsernameFailure(error: String) {
        activityIndicator.stopAnimating()
        print(error)
    }
    
    // MARK: - Get Followers Of User Service
    
    func getFollowersOfUser(username: String) {
        presenter?.getFollowersOfUser(username: username)
    }
    
    func onGetFollowersOfUserSuccess(result: [SearchUserResult]) {
        activityIndicator.stopAnimating()
        
        updateFollowButton()
    }
    
    func onGetFollowersOfUserFailure(error: String) {
        activityIndicator.stopAnimating()
        print(error)
    }
    
    // MARK: - Follow User Service
    
    func followUser(username: String) {
        presenter?.followUser(username: username)
    }
    
    func onFollowUserSuccess() {
        activityIndicator.stopAnimating()
        
        isFollowing = true
        
        updateFollowButton()
    }
    
    func onFollowUserFailure(error: String) {
        activityIndicator.stopAnimating()
        print(error)
    }
    
    // MARK: - Unfollow User Service
    
    func unfollowUser(username: String) {
        presenter?.unfollowUser(username: username)
    }
    
    func onUnfollowUserSuccess() {
        activityIndicator.stopAnimating()
        
        isFollowing = false
        
        updateFollowButton()
    }
    
    func onUnfollowUserFailure(error: String) {
        activityIndicator.stopAnimating()
        print(error)
    }
}

extension TopicListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
        
        if isUserPage {
            cell.configureWithDelete(itemInformation: contentList[indexPath.row])
        }
        else {
            cell.configureWithoutDelete(itemInformation: contentList[indexPath.row])
        }
        
        cell.deleteButton.tag = indexPath.row
        cell.linkDirectionButton.tag = indexPath.row
        cell.contentCellActionHandler = self
        
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3.0
        return cell
    }
    
}

extension TopicListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell") as! ContentTableViewCell
        
        cell.configure(itemInformation: contentList[indexPath.row])
    
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
