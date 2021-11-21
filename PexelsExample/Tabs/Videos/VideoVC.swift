//
//  VideoVC.swift
//  PexelsExample
//
//  Created by demothreen on 10.11.2021.
//

import UIKit
import AVKit

class VideoVC: UIViewController,
               UICollectionViewDelegateFlowLayout,
               UICollectionViewDataSource,
               PinterestLayoutDelegate {
  var model = VideoVM()
  lazy var navTitle: String = "" {
    didSet {
      configureNavBar(titleColor: .cDarkestGray, backgoundColor: .cLightGray, tintColor: .cDarkestGray, title: navTitle)
    }
  }
  fileprivate var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: CustomLayout())
    view.register(VideoCell.self, forCellWithReuseIdentifier: "Cell")
    view.backgroundColor = .clear
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .cLightGray
    navTitle = "Videos"
    model.getData()
    model.updateHandler = {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
    model.loadedMore = { rows in
      var newRows = [IndexPath]()
      for item in rows {
        newRows.append(IndexPath(row: item, section: 0))
      }
      DispatchQueue.main.async {
        self.collectionView.insertItems(at: newRows)
      }
    }
    setCollectionView()
  }

  private func setCollectionView() {
    view.addSubview(collectionView)
    let layout = CustomLayout()
    layout.delegate = self
    collectionView.collectionViewLayout = layout
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.alwaysBounceVertical = false
    collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    collectionView.snp.makeConstraints { make in
      make.top.left.right.bottom.equalTo(view)
    }
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model.data.count
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let url = model.data[indexPath.row].video_files[0].link, let videoUrl = URL(string: url) {
      let videoVC = PlayerVC()
      videoVC.videoUrl = videoUrl
      present(videoVC, animated: true, completion: nil)
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! VideoCell // swiftlint:disable:this force_cast line_length
    cell.video = model.data[indexPath.row]
    cell.saveFavorite = { [unowned self] in
      //      print(model.data[indexPath.row].photographer)
    }
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // swiftlint:disable:this line_length
    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2 // swiftlint:disable:this line_length
    return CGSize(width: itemSize, height: itemSize)
  }

  // swiftlint:disable:next line_length
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row == model.data.count - 1 {
      model.loadMore()
    }
  }

  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
    let picWidth = UIScreen.main.bounds.width / 2 - 20
    let picHeight = Int(picWidth) * model.data[indexPath.item].height / model.data[indexPath.item].width
    return CGFloat(picHeight)
  }
}
