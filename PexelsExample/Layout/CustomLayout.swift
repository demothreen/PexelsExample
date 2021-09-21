//
//  CustomLayout.swift
//  PexelsExample
//
//  Created by demothreen on 20.09.2021.
//

import UIKit

protocol CustomLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class CustomLayout: UICollectionViewLayout {
  weak var delegate: CustomLayoutDelegate?
  private let numberOfColumn: Int = 2
  private let cellPadding: Int = 6


}
