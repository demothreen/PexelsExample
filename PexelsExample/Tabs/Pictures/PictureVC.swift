//
//  PictureVC.swift
//  PexelsExample
//
//  Created by demothreen on 03.09.2021.
//

import UIKit

class PictureVC: UIViewController {

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar(largeTitleColor: .black, backgoundColor: .white, tintColor: .black, title: "Pictures", preferredLargeTitle: true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

  }
}
