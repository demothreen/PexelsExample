//
//  PictureCVCell.swift
//  PexelsExample
//
//  Created by demothreen on 19.09.2021.
//

import UIKit

class PictureCVCell: UICollectionViewCell {
  let imageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    return image
  }()
  var photo: Photo? {
    didSet {
      setPhotoData()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setImageView()
  }

  private func setImageView() {
    contentView.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.top.bottom.left.right.equalTo(contentView)
    }
  }

  private func setPhotoData() {
    if let photoData = photo {
      imageView.downloaded(from: URL(string: photoData.src.small)!)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
