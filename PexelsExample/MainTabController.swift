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
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let pictureVC = PictureVC()
    let videoVC = VideoVC()
    let pictureIcon = UITabBarItem(title: "Pictures", image: UIImage(named: "picture"), tag: 1)
    let videoIcon = UITabBarItem(title: "Videos", image: UIImage(named: "video"), tag: 1)
    pictureVC.tabBarItem = pictureIcon
    videoVC.tabBarItem = videoIcon
    let controllers = [pictureVC, videoVC]
    self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
  }

  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    return true
  }
}
