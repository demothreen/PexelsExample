//
//  PictureVM.swift
//  PexelsExample
//
//  Created by demothreen on 17.09.2021.
//

import Foundation

protocol MainModelProtocol {
  associatedtype Model
  var data: [Model] {get set}
  var updateHandler: (() -> Void)? { get set }
  var loadedMore: ((_ rows: [Int]) -> Void)? { get set }
  func getData()
  func loadMore()
}

class PictureVM: MainModelProtocol {
  typealias Model = Photo

  private var page: Int = 1
  var data: [Model] = []
  var updateHandler: (() -> Void)?
  var loadedMore: ((_ rows: [Int]) -> Void)?

  func getData() {
    let params: [SearchParams: Any] = [.page: page]
    Api.shared.getPopularPhotos(params: params) { pictures, err in
      if err == nil {
        if self.page == 1 {
          self.data = pictures
          self.updateHandler?()
        } else {
          let nowCount = self.data.count
          self.data += pictures
          let newCount = self.data.count
          let rouwsToAdd: [Int] = Array((nowCount)...(newCount-1))
          for item in pictures {
            self.data.append(item)
          }
          self.loadedMore?(rouwsToAdd)
        }
      }
    }
  }

  func loadMore() {
    page += 1
    getData()
  }
}
