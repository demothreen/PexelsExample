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
  private var page: Int = 1
  weak var delegate: PictureVMDelegate?
  var photos: [Photo] = [] {
    didSet {
      delegate?.photosUpdated()
    }
  }

  func getPhotos() {
    let params: [SearchParams: Any] = [.page: page]
    Api.shared.getPopularPhotos(params: params) { photos, err in
      if err == nil {
        self.photos = photos
      }
    }
  }
}
