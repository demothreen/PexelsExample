//
//  MainAssembly.swift
//  PexelsExample
//
//  Created by demothreen on 17.05.2022.
//

import Swinject
import SwinjectAutoregistration

class MainAssembly: Assembly {
  func assemble(container: Container) {

    container.autoregister(VideoVM.self, initializer: VideoVM.init)
    container.autoregister(VideoVC.self, initializer: VideoVC.init)

    container.autoregister(PictureVM.self, initializer: PictureVM.init)
    container.autoregister(PictureVC.self, initializer: PictureVC.init)
  }
}
