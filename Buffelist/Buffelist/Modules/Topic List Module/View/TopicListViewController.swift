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
        
        subTopicListView.addItemToListButton.style = .grayTextGrayBorder
        
        subTopicListView.collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ContentCollectionViewCell")
        subTopicListView.collectionView.allowsSelection = false
        
        subTopicListView.tableView.register(UINib(nibName: "ContentTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ContentTableViewCell")
        subTopicListView.tableView.allowsSelection = false
        
        subTopicListView.segmentedControl.selectedSegmentIndex = 0
        
        if UserProvider.users().count != 0 && username == UserProvider.user().username {
            isUserPage = true
            
            subTopicListView.usernameTitleLabel.text = String("Your Reading List").uppercased()
            
            subTopicListView.userImageView.downloaded(from: UserProvider.user().profilePhotoURL)
            
            subTopicListView.followButton.isHidden = true
            subTopicListView.followButton.isEnabled = false
            
            subTopicListView.addItemToListButton.isHidden = false
            subTopicListView.addItemToListButton.isEnabled = true
        }
        else if username == "trends" {
            isUserPage = false
            
            subTopicListView.usernameTitleLabel.text = username.uppercased()
            
            subTopicListView.userImageView.downloaded(from: profilePhotoURL)
            
            subTopicListView.followButton.isHidden = false
            subTopicListView.followButton.isEnabled = true
            
            subTopicListView.addItemToListButton.isHidden = true
            subTopicListView.addItemToListButton.isEnabled = false
            
            if UserProvider.users().count != 0 {
                searchUserByUsername(username: username)
            }
            else {
                subTopicListView.followButton.isHidden = true
                subTopicListView.followButton.isEnabled = false
            }
        }
        else {
            isUserPage = false
            
            subTopicListView.usernameTitleLabel.text = "\(username.uppercased())'S LIST"
            
            if profilePhotoURL != "" {
                subTopicListView.userImageView.downloaded(from: profilePhotoURL)
            }
            else {
                subTopicListView.userImageView.image = UIImage(named: "astronaut")
            }
            
            subTopicListView.followButton.isHidden = false
            subTopicListView.followButton.isEnabled = true
            
            subTopicListView.addItemToListButton.isHidden = true
            subTopicListView.addItemToListButton.isEnabled = false
            
            if UserProvider.users().count != 0 {
                searchUserByUsername(username: username)
            }
            else {
                subTopicListView.followButton.isHidden = true
                subTopicListView.followButton.isEnabled = false
            }
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupUIFunctionality() {
        subTopicListView.segmentedControl?.addTarget(self, action: #selector(self.segmentedControlChanged(_:)), for: .valueChanged)
        
        subTopicListView.addItemToListButton.addTarget(self, action: #selector(self.addItemToListButtonPressed), for: .touchUpInside)
        
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
    
    func showLoginOrRegisterPopup() {
        let popupVC = PopupViewController()
        popupVC.alertContent = AlertContentConfig( alertInformationText: "Login or register required. To unlock all features let's join the community.", alertUpButtonTitle: "Login Or Register", alertDownButtonTitle: "Close", popupType: PopupType.twoButtonNotextField)
        
        popupVC.didTapUpButton = { _ in
            self.popup?.dismiss()
            self.navigateToLogin()
        }
        
        popupVC.didTapDownButton = {
            self.popup?.dismiss()
        }
        
        popup = PopupDialog(viewController: popupVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, tapGestureDismissal: false, panGestureDismissal: false)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func navigateToLogin() {
        presenter?.navigateToLogin()
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
    
    @objc func addItemToListButtonPressed() {
        let popupVC = PopupViewController()
        popupVC.alertContent = AlertContentConfig( alertInformationText: "Enter Content URL", alertUpButtonTitle: "Check Content Availability", alertDownButtonTitle: "", popupType: PopupType.textFieldOneButton)
        
        popupVC.didTapUpButton = { text in
            if let text = text {
                self.popup?.dismiss()
                self.activityIndicator.startAnimating()
                self.presenter?.getInfoFromUrl(url: text)
            }
        }
        
        popup = PopupDialog(viewController: popupVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, tapGestureDismissal: true, panGestureDismissal: false)
        self.present(popup!, animated: true, completion: nil)
    }
    
    @objc func followButtonPressed() {
        if isFollowing {
            unfollowUser(username: username)
        }
        else {
            followUser(username: username)
        }
    }
    
    func deletePressed(sender: UIButton) {
        deleteContent(contentId: contentList[sender.tag].id)
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
    
    // MARK: - Get Info From Url Service
    
    func onGetInfoFromUrlSuccess(result: GetInfoFromUrlResult) {
        activityIndicator.stopAnimating()
        
        let popupVC = PopupViewController()
        popupVC.alertContent = AlertContentConfig( alertInformationText: "Select Content Title", alertUpButtonTitle: "Add", alertDownButtonTitle: "Cancel", popupType: PopupType.textFieldOneButton)
        popupVC.subPopupView.popupInformationTextField.text = result.title
        
        popupVC.didTapUpButton = { contentTitle in
            self.createContent(info: result, contentTitle: contentTitle ?? "")
            self.popup?.dismiss()
        }
        
        popupVC.didTapDownButton = {
            self.popup?.dismiss()
        }
        
        popup = PopupDialog(viewController: popupVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, tapGestureDismissal: true, panGestureDismissal: false)
        self.present(popup!, animated: true, completion: nil)
        
    }
    
    func onGetInfoFromUrlFailure(error: String) {
        activityIndicator.stopAnimating()
        print(error)
    }
    
    // MARK: - Create Content Service
    
    func createContent(info: GetInfoFromUrlResult, contentTitle: String) {
        self.activityIndicator.startAnimating()
        presenter?.createContent(info: info, contentTitle: contentTitle, contentListId: UserProvider.user().contentListId)
    }
    
    func onCreateContentSuccess(result: CreateContentResult) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.getContentList(username: self.username)
        }
    }
    
    func onCreateContentFailure(error: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        print(error)
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
    
    // MARK: - Delete Content Service
    
    func deleteContent(contentId: Int) {
        self.activityIndicator.startAnimating()
        presenter?.deleteContent(contentId: contentId)
    }
    
    func onDeleteContentSuccess() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.getContentList(username: self.username)
        }
    }
    
    func onDeleteContentFailure(error: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
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
