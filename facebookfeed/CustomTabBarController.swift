//
//  CustomTabBarController.swift
//  facebookfeed
//
//  Created by Ryan Lilla on 8/29/19.
//  Copyright © 2019 Ryan Lilla. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // News Feed tab
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        // Friend Requests tab
        let friendRequestController = FriendRequestsController()
        friendRequestController.navigationItem.title = "Friend Requests"
        let secondNavigationController = UINavigationController(rootViewController: friendRequestController)
        secondNavigationController.title = "Friend Requests"
        secondNavigationController.tabBarItem.image = UIImage(named: "requests_icon")
        
        // Messenger tab
        let messengerController = UIViewController()
        messengerController.navigationItem.title = "Messenger"
        let thirdNavigationController = UINavigationController(rootViewController: messengerController)
        thirdNavigationController.title = "Messenger"
        thirdNavigationController.tabBarItem.image = UIImage(named: "messenger_icon")
        
        // Notifications tab
        let notificationsController = UIViewController()
        notificationsController.navigationItem.title = "Notifications"
        let fourthNavigationController = UINavigationController(rootViewController: notificationsController)
        fourthNavigationController.title = "Notifications"
        fourthNavigationController.tabBarItem.image = UIImage(named: "globe_icon")
        
        // More tab
        let moreContoller = UIViewController()
        moreContoller.navigationItem.title = "More"
        let fifthNavigationController = UINavigationController(rootViewController: moreContoller)
        fifthNavigationController.title = "More"
        fifthNavigationController.tabBarItem.image = UIImage(named: "more_icon")
        
        // The view controllers to be displayed by the tab bar interface
        viewControllers = [navigationController, secondNavigationController, thirdNavigationController, fourthNavigationController, fifthNavigationController]
        
        // Removes the transparency from the tab bar
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
}
