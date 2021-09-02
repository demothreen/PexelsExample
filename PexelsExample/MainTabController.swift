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
    customizeTabBarView()
  }

  private func customizeTabBarView() {
    let tabBarHeight = tabBar.frame.size.height
    self.tabBar.layer.masksToBounds = true
    self.tabBar.isTranslucent = true
    self.tabBar.barStyle = .default
    self.tabBar.layer.cornerRadius = tabBarHeight/3
    self.tabBar.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let viewWidth = self.view.bounds.width
    tabBar.frame = CGRect(x: 15, y: view.frame.maxY - 30 - 49, width: viewWidth - 30, height: 49)
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
    self.viewControllers = controllers
  }

  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    print("Should select viewController: \(viewController.title ?? "") ?")
    return true;
  }
}
