//
//  PictureVM.swift
//  PexelsExample
//
//  Created by demothreen on 17.09.2021.
//

import Foundation

protocol PictureVMDelegate: AnyObject {
  func photosUpdated()
  func loadedMore(rows: [Int])
}

class PictureVM {
  private var page: Int = 1
  weak var delegate: PictureVMDelegate?
  var photos: [Photo] = []

  func getPhotos() {
    let params: [SearchParams: Any] = [.page: page]
    Api.shared.getPopularPhotos(params: params) { photos, err in
      if err == nil {
        if self.page == 1 {
          self.photos = photos
          self.delegate?.photosUpdated()
        } else {
          let nowCount = self.photos.count
          self.photos += photos
          let newCount = self.photos.count
          let rouwsToAdd: [Int] = Array((nowCount)...(newCount-1))
          for item in photos {
            self.photos.append(item)
          }
          self.delegate?.loadedMore(rows: rouwsToAdd)
        }
      }
    }
  }

  func loadMore() {
    page += 1
    getPhotos()
  }
}
