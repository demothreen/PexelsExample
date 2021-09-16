//
//  PictureVM.swift
//  PexelsExample
//
//  Created by demothreen on 17.09.2021.
//

import Foundation

protocol PictureVMDelegate: AnyObject {
  func photosUpdated()
}

class PictureVM {
  weak var delegate: PictureVMDelegate?
  var photos: [Photos] = [] {
    didSet {
      delegate?.photosUpdated()
    }
  }

  func getPhotos() {
    Api.shared.getPopularPhotos { photos, err in
      if err == nil {
        self.photos = photos
      }
    }
  }
}
