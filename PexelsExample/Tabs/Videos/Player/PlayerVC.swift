//
//  PlayerVC.swift
//  PexelsExample
//
//  Created by demothreen on 21.11.2021.
//

import UIKit
import AVKit

class PlayerVC: AVPlayerViewController {
  var videoUrl: URL? {
    didSet {
      player = AVPlayer(url: videoUrl!)
      player?.play()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.contentMode = .scaleAspectFit
    showsPlaybackControls = true
  }
}
