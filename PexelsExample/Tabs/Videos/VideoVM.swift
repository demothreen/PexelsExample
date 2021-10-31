//
//  VideoVM.swift
//  PexelsExample
//
//  Created by demothreen on 31.10.2021.
//

import Foundation

class VideoVM: MainModelProtocol {
  typealias Model = Video

  private var page: Int = 1
  var data: [Model] = []
  var updateHandler: (() -> Void)?
  var loadedMore: ((_ rows: [Int]) -> Void)?

  func getData() {
    let params: [SearchParams: Any] = [.page: page]
    Api.shared.getPopularVideos(params: params) { videos, err in
      if err == nil {
        if self.page == 1 {
          self.data = videos
          self.updateHandler?()
        } else {
          let nowCount = self.data.count
          self.data += videos
          let newCount = self.data.count
          let rouwsToAdd: [Int] = Array((nowCount)...(newCount-1))
          for item in videos {
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
