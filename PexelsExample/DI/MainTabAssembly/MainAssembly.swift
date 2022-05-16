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

    container.autoregister(PictureVM.self, initializer: PictureVM.init)
    container.autoregister(PictureVC.self, initializer: PictureVC.init)
  }
}
