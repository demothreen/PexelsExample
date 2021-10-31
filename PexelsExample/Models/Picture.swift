//
//  Picture.swift
//  PexelsExample
//
//  Created by demothreen on 16.09.2021.
//

import Foundation

struct PhotoResult: Codable {
  let total_results: Int // swiftlint:disable:this identifier_name
  let page: Int
  let per_page: Int // swiftlint:disable:this identifier_name
  let next_page: String // swiftlint:disable:this identifier_name
  let photos: [Photo]
}

struct Photo: Codable {
  let id: Int // swiftlint:disable:this identifier_name
  let width: Int
  let height: Int
  let url: String
  let photographer: String
  let photographer_url: String // swiftlint:disable:this identifier_name
  let photographer_id: Int // swiftlint:disable:this identifier_name
  let avg_color: String // swiftlint:disable:this identifier_name
  let liked: Bool
  let src: PhotoSrc
}

struct PhotoSrc: Codable {
  var original: String
  var large2x: String
  var large: String
  var medium: String
  var small: String
  var portrait: String
  var landscape: String
  var tiny: String
}
