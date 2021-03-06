//
//  PictureCVCell.swift
//  PexelsExample
//
//  Created by demothreen on 19.09.2021.
//

import UIKit

class PictureCell: UICollectionViewCell {
  private let imageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    return image
  }()
  private var photographerName: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    label.backgroundColor = .black.withAlphaComponent(0.6)
    return label
  }()
  private var favBtn: UIButton = {
    var favBtn = UIButton()
    favBtn.setImage(UIImage(named: "favorite")?.withRenderingMode(.alwaysTemplate), for: .normal)
    favBtn.imageView?.tintColor = .white
    return favBtn
  }()
  var saveFavorite: (() -> Void)?
  var photo: Photo? {
    didSet {
      setPhotoData()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: .zero)
    setImageView()
    setPhotographerName()
    setFavIcon()
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

  private func setFavIcon() {
    contentView.addSubview(favBtn)
    favBtn.snp.makeConstraints { make in
      make.right.top.equalTo(imageView).inset(5)
    }
    favBtn.isUserInteractionEnabled = true
    favBtn.addTarget(self, action: #selector(tapFav), for: .touchUpInside)
  }

  @objc private func tapFav(sender: UIButton) {
    saveFavorite?()
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
