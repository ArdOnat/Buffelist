//
//  TopicListViewController.swift
//  Buffelist
//
//  Created by Arda Onat on 3.10.2020.
//

import Foundation

import PopupDialog

class TopicListViewController: UIViewController {

    var presenter: TopicListViewToPresenterProtocol?
    
    var subTopicListView: TopicListView!
    var popup: PopupDialog?
    var vSpinner : UIView?
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    var contentList = [ContentModel]()
    var username:String = ""
    var isFollowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupUIFunctionality()
        setupDelegation()
        getContentList(username: username)
    }
    
    private func setupUI() {
        subTopicListView = view  as? TopicListView
        
        subTopicListView.addItemToListButton.style = .grayTextGrayBorder
        
        subTopicListView.collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ContentCollectionViewCell")
        subTopicListView.collectionView.allowsSelection = false
        
        subTopicListView.tableView.register(UINib(nibName: "ContentTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ContentTableViewCell")
        subTopicListView.tableView.allowsSelection = false
        
        subTopicListView.segmentedControl.selectedSegmentIndex = 0
        
        if username == UserProvider.user().username {
            subTopicListView.usernameTitleLabel.text = String("Your Reading List").uppercased()
            
            subTopicListView.followButton.isHidden = true
            subTopicListView.followButton.isEnabled = false
            
            subTopicListView.addItemToListButton.isHidden = false
            subTopicListView.addItemToListButton.isEnabled = true
        }
        else {
            subTopicListView.usernameTitleLabel.text = username.uppercased()
            
            subTopicListView.followButton.isHidden = false
            subTopicListView.followButton.isEnabled = true
            
            subTopicListView.addItemToListButton.isHidden = true
            subTopicListView.addItemToListButton.isEnabled = false
            
            getFollowersOfUser(username: username)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setupUIFunctionality() {
        subTopicListView.segmentedControl?.addTarget(self, action: #selector(self.segmentedControlChanged(_:)), for: .valueChanged)
        
        subTopicListView.addItemToListButton.addTarget(self, action: #selector(self.addItemToListButtonPressed), for: .touchUpInside)
        
        subTopicListView.followButton.addTarget(self, action: #selector(self.followButtonPressed), for: .touchUpInside)
    }
    
    private func setupDelegation() {
        subTopicListView.collectionView.delegate = self
        subTopicListView.collectionView.dataSource = self
        
        subTopicListView.tableView.delegate = self
        subTopicListView.tableView.dataSource = self
    }
    
    private func updateFollowButton() {
        if isFollowing {
            subTopicListView.followButton.style = .redBackgroundWhiteTextNoRadius
            subTopicListView.followButton.updateTitleAndImage(title: "Unfollow")
        }
        else {
            subTopicListView.followButton.style = .greenBackgroundWhiteText
            subTopicListView.followButton.updateTitleAndImage(title: "Follow")
        }
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
    
}

extension TopicListViewController: TopicListPresenterToViewProtocol {
 
    // MARK: - Get Content List Service
    
    func getContentList(username: String) {
        self.activityIndicator.startAnimating()
        presenter?.getContentList(username: username)
    }
    
    func onGetContentListSuccess(contentList: [ContentModel]) {
        self.contentList = contentList
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.subTopicListView.collectionView.reloadData()
            self.subTopicListView.tableView.reloadData()
        }
    }
    
    func onGetContentListFailure(error: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        print(error)
    }
    
    // MARK: - Get Info From Url Service
    
    func onGetInfoFromUrlSuccess(result: GetInfoFromUrlResult) {
        activityIndicator.stopAnimating()
        
        let popupVC = PopupViewController()
        popupVC.alertContent = AlertContentConfig( alertInformationText: "Select Content Title", alertUpButtonTitle: "Add", alertDownButtonTitle: "Cancel", popupType: PopupType.textFieldOneButton)
        
        
        popupVC.didTapUpButton = { text in
            self.createContent(info: result)
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
    
    func createContent(info: GetInfoFromUrlResult) {
        self.activityIndicator.startAnimating()
        presenter?.createContent(info: info)
    }
    
    func onCreateContentSuccess(result: CreateContentResult) {
        activityIndicator.stopAnimating()
    }
    
    func onCreateContentFailure(error: String) {
        activityIndicator.stopAnimating()
        print(error)
    }
    
    // MARK: - Get Followers Of User Service
    
    func getFollowersOfUser(username: String) {
        presenter?.getFollowersOfUser(username: username)
    }
    
    func onGetFollowersOfUserSuccess(result: [SearchUserResult], isFollowing: Bool) {
        activityIndicator.stopAnimating()
        
        self.isFollowing = isFollowing
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
        
        cell.configure(itemInformation: contentList[indexPath.row])
        
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

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
