//
//  TabBarViewController.swift
//  mars
//
//  Created by mars uzhanov on 20.02.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
//        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
//        leftSwipeGesture.direction = .left
//        view.addGestureRecognizer(leftSwipeGesture)
//        
//        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
//        rightSwipeGesture.direction = .right
//        view.addGestureRecognizer(rightSwipeGesture)
    }
    
//    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
//            guard let viewControllers = viewControllers, let selectedViewController = selectedViewController else { return }
//
//            var newIndex = selectedIndex
//
//            if gesture.direction == .left {
//                newIndex = (selectedIndex + 1) % viewControllers.count
//            } else if gesture.direction == .right {
//                newIndex = (selectedIndex + viewControllers.count - 1) % viewControllers.count
//            }
//
//            if newIndex != selectedIndex {
//                let currentViewController = selectedViewController
//                let newViewController = viewControllers[newIndex]
//
//                UIView.transition(from: currentViewController.view,
//                                  to: newViewController.view,
//                                  duration: 0.3,
//                                  options: [.allowAnimatedContent, .showHideTransitionViews],
//                                  completion: { _ in
//                                      self.selectedIndex = newIndex
//                                  })
//            }
//        }
    
    func setupViewControllers() {
        let home = HomeViewController()
        let search = SearchViewController()
        let library = ProfileViewController()
        
        home.title = "Home"
        search.title = "Search"
        library.title = "Your library"
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: search)
        let nav3 = UINavigationController(rootViewController: library)
        
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.crop.circle"), tag: 1)
        
        tabBar.tintColor = .orange
        
        let controllers = [nav1, nav2, nav3]
        setViewControllers(controllers, animated: true)
    }
}
