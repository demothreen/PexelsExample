//
//  PictureVC.swift
//  PexelsExample
//
//  Created by demothreen on 03.09.2021.
//

import UIKit
import SnapKit

class PictureVC: BaseVC {
  private let pictureVM = PictureVM()
  fileprivate var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    view.backgroundColor = .clear
    return view
  }()

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navTitle = "Pictures"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    pictureVM.delegate = self
    pictureVM.getPhotos()
    setCollectionView()
  }

  private func setCollectionView() {
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.snp.makeConstraints { make in
      make.top.left.right.bottom.equalTo(view)
    }
  }
}

extension PictureVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pictureVM.photos.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
    //    cell.photo = photos[indexPath.item]
    cell.backgroundColor = .green
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // swiftlint:disable:this line_length
    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2 // swiftlint:disable:this line_length
    return CGSize(width: itemSize, height: itemSize)
  }
}

extension PictureVC: PictureVMDelegate {
  func photosUpdated() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
}
