//
//  PictureVC.swift
//  PexelsExample
//
//  Created by demothreen on 03.09.2021.
//

import UIKit

class PictureVC: BaseVC {
  private let pictureVM = PictureVM()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navTitle = "Pictures"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    pictureVM.delegate = self
    pictureVM.getPhotos()

  }
}

extension PictureVC: PictureVMDelegate {
  func photosUpdated() {
  }
}
