//
//  PictureCVCell.swift
//  PexelsExample
//
//  Created by demothreen on 19.09.2021.
//

import UIKit

class PictureCVCell: UICollectionViewCell {
  private let imageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    return image
  }()
  private var photographerName: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    label.backgroundColor = .black.withAlphaComponent(0.4)
    return label
  }()
  var photo: Photo? {
    didSet {
      setPhotoData()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setImageView()
    setPhotographerName()
  }

  private func setImageView() {
    contentView.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.top.bottom.left.right.equalTo(contentView)
    }
  }

  private func setPhotographerName() {
    imageView.addSubview(photographerName)
    photographerName.snp.makeConstraints { make in
      make.left.bottom.right.equalTo(imageView)
      make.height.equalTo(16)
    }
  }

  private func setPhotoData() {
    if let photoData = photo {
      imageView.downloaded(from: URL(string: photoData.src.small)!)
      photographerName.text = photoData.photographer
      imageView.layer.cornerRadius = 10
      imageView.layer.masksToBounds = true
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
