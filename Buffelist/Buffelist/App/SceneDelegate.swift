//
//  SceneDelegate.swift
//  Buffelist
//
//  Created by Arda Onat on 22.09.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let tabBarController = UITabBarController()
        let topicListModuleBuilder = TopicListModuleBuilder()
        let myListModuleBuilder = MyListModuleBuilder()
        let peopleListModuleBuilder = PeopleListModuleBuilder()
        let profileModuleBuilder = ProfileModuleBuilder()
        
        if UserProvider.users().count == 0 {
            let homeModuleBuilder = HomeModuleBuilder()
            
            let homeModule = homeModuleBuilder.createModule()
            let vc1 = topicListModuleBuilder.createModule(username: "trends")
            let vc2 = myListModuleBuilder.createModule(username: "")
            let vc3 = peopleListModuleBuilder.createModule(username: "")
            let vc4 = profileModuleBuilder.createModule()
            
            tabBarController.tabBar.tintColor = .black
            
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!], for: .selected)
            
            vc1.tabBarItem = UITabBarItem(title: "Trend Contents", image: UIImage(named: "trends"), tag: 1)
            vc2.tabBarItem = UITabBarItem(title: "My List", image: UIImage(named: "list"), tag: 2)
            vc3.tabBarItem = UITabBarItem(title: "People", image: UIImage(named: "people"), tag: 3)
            vc4.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "people"), tag: 4)
            
            tabBarController.viewControllers = [vc1, vc2, vc3, vc4]
        }
        else {
            let vc1 = topicListModuleBuilder.createModule(username: "trends")
            let vc2 = myListModuleBuilder.createModule(username: UserProvider.user().username)
            let vc3 = peopleListModuleBuilder.createModule(username: UserProvider.user().username)
            let vc4 = profileModuleBuilder.createModule()
            
            tabBarController.tabBar.tintColor = .black
            
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!], for: .selected)
            
            vc1.tabBarItem = UITabBarItem(title: "Trend Contents", image: UIImage(named: "trends"), tag: 1)
            vc2.tabBarItem = UITabBarItem(title: "My List", image: UIImage(named: "list"), tag: 2)
            vc3.tabBarItem = UITabBarItem(title: "People", image: UIImage(named: "people"), tag: 3)
            vc4.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "people"), tag: 4)

            tabBarController.viewControllers = [vc1, vc2, vc3, vc4]
        }
        
        tabBarController.setViewControllers(tabBarController.viewControllers, animated: true)
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

