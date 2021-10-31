//
//  Api.swift
//  PexelsExample
//
//  Created by demothreen on 15.09.2021.
//

import Foundation
import UIKit

enum SearchParams: String {
  case perPage = "per_page"
  case page
}

enum RequestMethod: String {
  case GET
  case POST
  case PUT
  case DELETE
}

class Api {
  static let shared = Api()
  private let token = Bundle.main.object(forInfoDictionaryKey: "API_KEY")

  // swiftlint:disable:next line_length
  private func makeHTTPRequest<T: Codable>(model: T.Type, url: String, method: RequestMethod, onCompletion: @escaping(T?, Error?) -> Void) {
    guard let apiToken = token as? String else {
      onCompletion(nil, nil)
      return
    }
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = method.rawValue
    request.allHTTPHeaderFields = ["Authorization": apiToken]
    let task = URLSession.shared.dataTask(with: request) { data, response, error -> Void in
      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        onCompletion(nil, error)
        return
      }
      if let data = data {
        let pics = try? JSONDecoder().decode(model, from: data)
        onCompletion(pics, error)
        return
      } else {
        onCompletion(nil, error)
        return
      }
    }
    task.resume()
  }

  func getPopularPhotos(params: [SearchParams: Any], onComplition: @escaping ([Photo], NSError?) -> Void) {
    var page: Int = 1
    if params[.page] != nil {
      page = params[.page] as? Int ?? 1
    }
    let url = "https://api.pexels.com/v1/popular/?page=\(page)"
    makeHTTPRequest(model: PhotoResult.self, url: url, method: .GET) { data, error in
      onComplition(data?.photos ?? [], error as NSError?)
    }
  }

  func getPopularVideos(params: [SearchParams: Any], onComplition: @escaping ([Video], NSError?) -> Void) {
    var page: Int = 1
    if params[.page] != nil {
      page = params[.page] as? Int ?? 1
    }
    let url = "https://api.pexels.com/v1/videos/popular/?page=\(page)"
    makeHTTPRequest(model: VideoResult.self, url: url, method: .GET) { data, error in
      onComplition(data?.videos ?? [], error as NSError?)
    }
  }
}
