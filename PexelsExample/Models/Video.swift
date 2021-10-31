//
//  Video.swift
//  PexelsExample
//
//  Created by demothreen on 31.10.2021.
//

import Foundation

struct VideoResult: Codable {
  let total_results: Int // swiftlint:disable:this identifier_name
  let page: Int
  let per_page: Int // swiftlint:disable:this identifier_name
  let next_page: String // swiftlint:disable:this identifier_name
  let videos: [Video]
}
struct Video: Codable {
  let id: Int // swiftlint:disable:this identifier_name
  let width: Int
  let height: Int
  let duration: Int
  let url: String
  let image: String
  let user: User
  let videoFiles: [VideoFile]
  let videoPictures: [VideoPictures]
}

struct User: Codable {
  let id: Int // swiftlint:disable:this identifier_name
  let name: String
  let url: String
}

struct VideoFile: Codable {
  let id: Int // swiftlint:disable:this identifier_name
  let quality: String
  let fileType: String
  let height: Int
  let width: Int
  let link: String
}

struct VideoPictures: Codable {
  let id: Int // swiftlint:disable:this identifier_name
  let picture: String
}
