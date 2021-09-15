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
    let favVC = FavoriteVC()
    pictureVC.tabBarItem = getTabBarItem(title: "Pictures", imgName: "picture")
    videoVC.tabBarItem = getTabBarItem(title: "Videos", imgName: "video")
    favVC.tabBarItem = getTabBarItem(title: "Favorite", imgName: "favorite")
    let controllers = [pictureVC, videoVC, favVC]
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

  private func getTabBarItem(title: String, imgName: String) -> UITabBarItem {
    let item = UITabBarItem(title: title, image: UIImage(named: imgName), tag: 1)
    item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    return item
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tabBar.frame = CGRect(x: 10, y: view.frame.maxY-10-49, width: view.frame.width-20, height: 49)
  }

  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    return true
  }
}
