//
//  MainTabController.swift
//  PexelsExample
//
//  Created by demothreen on 03.09.2021.
//

import UIKit

class MainTabController: UITabBarController, UITabBarControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    customizeTabBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let pictureVC = PictureVC()
    let videoVC = VideoVC()
    pictureVC.tabBarItem = UITabBarItem(title: "Pictures", image: UIImage(named: "picture"), tag: 1)
    videoVC.tabBarItem = UITabBarItem(title: "Videos", image: UIImage(named: "video"), tag: 1)
    let controllers = [pictureVC, videoVC]
    self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
  }

  private func customizeTabBar() {
    self.tabBar.isTranslucent = true
    self.tabBar.barTintColor = .cDarkGreen
    self.tabBar.layer.masksToBounds = true
    UITabBar.appearance().tintColor = .cYellow
    self.tabBar.unselectedItemTintColor = .white
    let tabBarHeight = tabBar.frame.size.height
    self.tabBar.layer.cornerRadius = tabBarHeight/2
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tabBar.frame = CGRect(x: 10, y: view.frame.maxY-10-49, width: view.frame.width-20, height: 49)
  }

  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    return true
  }
}
