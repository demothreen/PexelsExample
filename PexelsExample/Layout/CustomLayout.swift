//
//  CustomLayout.swift
//  PexelsExample
//
//  Created by demothreen on 20.09.2021.
//

import UIKit

extension CGRect {
  func dividedIntegral(fraction: CGFloat, from fromEdge: CGRectEdge) -> (first: CGRect, second: CGRect) {
    let dimension: CGFloat
    switch fromEdge {
    case .minXEdge, .maxXEdge:
      dimension = size.width
    case .minYEdge, .maxYEdge:
      dimension = size.height
    }
    let distance = (dimension * fraction).rounded(.up)
    var slices = divided(atDistance: distance, from: fromEdge)
    switch fromEdge {
    case .minXEdge, .maxXEdge:
      slices.remainder.origin.x += 1
      slices.remainder.size.width -= 1
    case .minYEdge, .maxYEdge:
      slices.remainder.origin.y += 1
      slices.remainder.size.height -= 1
    }
    return (first: slices.slice, second: slices.remainder)
  }
}

class CustomLayout: UICollectionViewLayout {
  var contentBounds = CGRect.zero
  var cachedAttributes = [UICollectionViewLayoutAttributes]()
  var scrollDirection: UICollectionView.ScrollDirection = .vertical
  var lastframetest = CGRect()

  override func prepare() {
    super.prepare()
    if scrollDirection == .vertical {
      prepareForVertical()
    } else {
      prepareForHorizontal()
    }
  }

  func prepareForVertical() {
    guard let collectionView = collectionView else { return }
    cachedAttributes.removeAll()
    contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
    let count = collectionView.numberOfItems(inSection: 0)
    var currentIndex = 0
    var lastFrame: CGRect = .zero
    let cvWidth = collectionView.bounds.size.width

    while currentIndex < count {
      let segmentFrame = CGRect(x: 0, y: lastFrame.maxY + 1.0, width: cvWidth, height: 200.0)
      var segmentRects = [CGRect]()
        let horizontalSlices = segmentFrame.dividedIntegral(fraction: 0.5, from: .minXEdge)
        segmentRects = [horizontalSlices.first, horizontalSlices.second]
      for rect in segmentRects {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: 0))
        attributes.frame = rect
        cachedAttributes.append(attributes)
        lastFrame = rect
        contentBounds = contentBounds.union(lastFrame)
        currentIndex += 1
        lastframetest = lastFrame
      }
    }
  }

  func prepareForHorizontal() {
    guard let collectionView = collectionView else { return }
    cachedAttributes.removeAll()
    contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
    let count = collectionView.numberOfItems(inSection: 0)
    var currentIndex = 0
    var lastFrame: CGRect = .zero
    let cHeight = collectionView.bounds.size.height
    while currentIndex < count {
      let segmentFrame = CGRect(x: lastFrame.maxX - 1, y: 0, width: 300, height: cHeight - 10)
      var segmentRects = [CGRect]()
        let horizontalSlices = segmentFrame.dividedIntegral(fraction: 0.5, from: .minYEdge)
        segmentRects = [horizontalSlices.first, horizontalSlices.second]
      for rect in segmentRects {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: 0))
        attributes.frame = rect

        cachedAttributes.append(attributes)
        contentBounds = contentBounds.union(lastFrame)
        currentIndex += 1
        lastFrame = rect
      }
    }
  }

  override var collectionViewContentSize: CGSize {
    return contentBounds.size
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    guard let collectionView = collectionView else { return false }
    return !newBounds.size.equalTo(collectionView.bounds.size)
  }

  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cachedAttributes[indexPath.item]
  }

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var attributesArray = [UICollectionViewLayoutAttributes]()
    guard let lastIndex = cachedAttributes.indices.last,
          let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex) else { return attributesArray }
    for attributes in cachedAttributes[..<firstMatchIndex].reversed() {
      guard attributes.frame.maxY >= rect.minY else { break }
      attributesArray.append(attributes)
    }

    for attributes in cachedAttributes[firstMatchIndex...] {
      guard attributes.frame.minY <= rect.maxY else { break }
      attributesArray.append(attributes)
    }
    return attributesArray
  }

  func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
    if end < start { return nil }
    let mid = (start + end) / 2
    let attr = cachedAttributes[mid]
    if attr.frame.intersects(rect) {
      return mid
    } else {
      if attr.frame.maxY < rect.minY {
        return binSearch(rect, start: (mid + 1), end: end)
      } else {
        return binSearch(rect, start: start, end: (mid - 1))
      }
    }
  }
}
