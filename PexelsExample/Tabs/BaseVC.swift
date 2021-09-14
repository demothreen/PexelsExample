//
//  BaseVC.swift
//  PexelsExample
//
//  Created by demothreen on 14.09.2021.
//

import UIKit

class BaseVC: UIViewController {
  lazy var navTitle: String = "" {
    didSet {
      configureNavBar(titleColor: .cDarkestGray, backgoundColor: .cLightGray, tintColor: .cDarkestGray, title: navTitle)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .cLightGray
  }
}
