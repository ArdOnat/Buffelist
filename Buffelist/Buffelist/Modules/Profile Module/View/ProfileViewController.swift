//
//  ProfileViewController.swift
//  Buffelist
//
//  Created by Arda Onat on 24.10.2020.
//

import UIKit
import PopupDialog

class ProfileViewController: UIViewController, OnTapKeyboardHideable, ProfileBottomHandler{
    
    var presenter: ProfileViewToPresenterProtocol?
    
    var popup: PopupDialog?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profilePictureView: ProfilePictureView!
    @IBOutlet weak var profileInformationLabel: ProfileInformationView!
    @IBOutlet weak var profileBottomView: ProfileBottomView!
    
    private var keyboardHandler: KeyboardHandler!
    
    var viewController: UIViewController? {
        return self
    }
    
    init() {
        super.init(nibName: "ProfileView", bundle: .main)
        NotificationCenter.default.addObserver(self, selector: #selector(AuthenticationStatusChanged(_:)), name: .didAuthenticationStatusChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserProvider.users().count == 0 {
            showLoginOrRegisterPopup()
        }
    }
    
    @objc func AuthenticationStatusChanged(_ notification:Notification) {
        profilePictureView.configurePage()
        profileInformationLabel.configurePage()
        profileBottomView.configurePage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupUIFunctionality()
        configureKeyboardHandler()
        setupDelegation()
        setupHideKeyboardOnTapRecognizer()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUIFunctionality() {
        
    }
    
    private func configureKeyboardHandler() {
        keyboardHandler = KeyboardHandler(with: scrollView, responders: [scrollView])
    }
    
    private func setupDelegation() {
        profileBottomView.profileBottomHandler = self
    }
    
    func logoutButtonPressed() {
        presenter?.logoutUser()
    }
    
    func showLoginOrRegisterPopup() {
        let popupVC = PopupViewController()
        popupVC.alertContent = AlertContentConfig( alertInformationText: "Login or register required. To unlock all features let's join the community.", alertUpButtonTitle: "LOGIN OR REGISTER", alertDownButtonTitle: "Close", popupType: PopupType.twoButtonNotextField)
        
        popupVC.didTapUpButton = { _ in
            self.popup?.dismiss()
            self.navigateToLogin()
        }
        
        popupVC.didTapDownButton = {
            self.popup?.dismiss()
        }
        
        popup = PopupDialog(viewController: popupVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, tapGestureDismissal: true, panGestureDismissal: false)
        self.present(popup!, animated: true, completion: nil)
    }
    
    func navigateToLogin() {
        presenter?.navigateToLogin()
    }
    
}

extension ProfileViewController: ProfilePresenterToViewProtocol {
    
    func getFollowingsOfUser(username: String) {
        
    }
    
    func onGetFollowingsOfUserSuccess(Profile: [SearchUserResult]) {
            
    }
    
    func onGetFollowingsOfUserFailure(error: String) {
        
    }
    
    func searchUser(username: String) {
        
    }
    
    func onSearchUserSuccess(Profile: [SearchUserResult]) {
        
    }
    
    func onSearchUserFailure(error: String) {
        
    }
    
}

extension Notification.Name {
    static let didAuthenticationStatusChanged = Notification.Name("didAuthenticationStatusChanged")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}
