//
//  ExtUIViewController.swift
//  PexelsExample
//
//  Created by demothreen on 14.09.2021.
//

import UIKit

extension UIViewController {
  func configureNavBar(titleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String) {
    if #available(iOS 13.0, *) {
      let navBarAppearance = UINavigationBarAppearance()
      navBarAppearance.configureWithOpaqueBackground()
      navBarAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
      navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor]
      navBarAppearance.backgroundColor = backgoundColor

      navigationController?.navigationBar.standardAppearance = navBarAppearance
      navigationController?.navigationBar.compactAppearance = navBarAppearance
      navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

      navigationController?.navigationBar.prefersLargeTitles = true
      navigationItem.largeTitleDisplayMode = .always
      navigationController?.navigationBar.isTranslucent = false
      navigationController?.navigationBar.tintColor = tintColor
      navigationItem.title = title
    } else {
      // Fallback on earlier versions
      navigationController?.navigationBar.barTintColor = backgoundColor
      navigationController?.navigationBar.tintColor = tintColor
      navigationController?.navigationBar.isTranslucent = false
      navigationItem.title = title
    }
  }
}
