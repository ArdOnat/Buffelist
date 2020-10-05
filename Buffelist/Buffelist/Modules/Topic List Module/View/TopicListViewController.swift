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
    var contentList = [ContentModel]()
    
    var username:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupUIFunctionality()
        setupDelegation()
        getContentList(username: username)
    }
    
    private func setupUI() {
        subTopicListView = view  as? TopicListView
        
        subTopicListView.followButton.style = .greenBackgroundWhiteText
        subTopicListView.addItemToListButton.style = .grayTextGrayBorder
        
        subTopicListView.collectionView.register(UINib(nibName: "ContentCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ContentCollectionViewCell")
        subTopicListView.collectionView.allowsSelection = false
        
        subTopicListView.tableView.register(UINib(nibName: "ContentTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ContentTableViewCell")
        subTopicListView.tableView.allowsSelection = false
        
        if username == UserProvider.user().username {
            subTopicListView.usernameTitleLabel.text = String("Your Reading List").uppercased()
            
            //subTopicListView.followButton.updateTitleAndImage(title: "Follow")
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
        }
    }
    
    private func setupUIFunctionality() {
        subTopicListView.segmentedControl?.addTarget(self, action: #selector(self.segmentedControlChanged(_:)), for: .valueChanged)
        
        subTopicListView.segmentedControl.selectedSegmentIndex = 0
    }
    
    private func setupDelegation() {
        subTopicListView.collectionView.delegate = self
        subTopicListView.collectionView.dataSource = self
        
        subTopicListView.tableView.delegate = self
        subTopicListView.tableView.dataSource = self
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
    
}

extension TopicListViewController: TopicListPresenterToViewProtocol {
 
    func getContentList(username: String) {
        presenter?.getContentList(username: username)
    }
    
    func onGetContentListSuccess(contentList: [ContentModel]) {
        self.contentList = contentList
        DispatchQueue.main.async {
            self.subTopicListView.collectionView.reloadData()
            self.subTopicListView.tableView.reloadData()
        }
    }
    
    func onGetContentListFailure(error: String) {
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
