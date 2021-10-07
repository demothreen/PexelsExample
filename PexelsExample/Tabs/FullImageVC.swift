//
//  FullImageVCViewController.swift
//  PexelsExample
//
//  Created by demothreen on 07.10.2021.
//

import UIKit

class FullImageVC: UIViewController {
  private var imageUrl: String?
  private var imageView: UIImageView = UIImageView()
  private var scrollView: UIScrollView = UIScrollView()

  init(url: String) {
    imageUrl = url
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    setScrollView()
    setImageView()
  }

  private func setScrollView() {
    view.addSubview(scrollView)
    scrollView.delegate = self
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.minimumZoomScale = 0.5
    scrollView.maximumZoomScale = 3
    scrollView.snp.makeConstraints { make in
      make.bottom.top.left.right.equalTo(view)
    }
  }

  private func setImageView() {
    scrollView.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.bottom.top.left.right.equalTo(view)
    }
    imageView.downloaded(from: URL(string: imageUrl!)!)
    scrollView.contentSize = imageView.bounds.size
  }
}

extension FullImageVC: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }

  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    if scrollView.zoomScale > 1 {
      let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0)
      let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0)
      scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    } else {
      scrollView.contentInset = .zero
    }
  }
}
