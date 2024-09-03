//
//  ViewController.swift
//  ASISProject3
//
//  Created by Armağan Gül on 25.08.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = UIColor(red: 0/255, green: 25/255, blue: 51/255, alpha: 1.0)
        createTabs()
    }
    
    func createTabs(){
        
        let forYou = UINavigationController(rootViewController: RecommendationsViewController())
        let explore  = UINavigationController(rootViewController: ExploreViewController())
        let likes = UINavigationController(rootViewController: LikesViewController())
        
        forYou.tabBarItem.image = UIImage(systemName: "house.fill")
        explore.tabBarItem.image = UIImage(systemName: "popcorn.fill")
        likes.tabBarItem.image = UIImage(systemName: "heart.fill")

        tabBar.tintColor = .label
        tabBar.backgroundColor = UIColor(red: 0/255, green: 25/255, blue: 51/255, alpha: 1.0)
        setViewControllers([forYou, explore, likes], animated: true)
    }
}

