//
//  MainContainer.swift
//  PexelsExample
//
//  Created by demothreen on 17.05.2022.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class MainContainer {
  private static let shared = MainContainer()
  private var assembler: Assembler

  private init() {
    assembler = Assembler(
      [
        MainAssembly(),
        AppAssembly()
      ]
    )
  }

  func resolve<T>(_ type: T.Type) -> T {
    let synchronizedResolver = (assembler.resolver as! Container).synchronize()
    return synchronizedResolver ~> (type)
  }
}

extension MainContainer {
  static func resolve<T>(_ type: T.Type) -> T {
    return MainContainer.shared.resolve(type)
  }
}
