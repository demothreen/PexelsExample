//
//  ExtColors.swift
//  PexelsExample
//
//  Created by demothreen on 15.09.2021.
//

import UIKit

extension UIColor {
  class var cDarkestGray: UIColor {
    if #available(iOS 11, *) {
      return UIColor(named: "cDarkestGray")!
    } else {
      return .cDarkestGray
    }
  }

  class var cDarkGray: UIColor {
    if #available(iOS 11, *) {
      return UIColor(named: "cDarkGray")!
    } else {
      return .cDarkGray
    }
  }

  class var cDarkGreen: UIColor {
    if #available(iOS 11, *) {
      return UIColor(named: "cDarkGreen")!
    } else {
      return .cDarkGreen
    }
  }

  class var cLightGray: UIColor {
    if #available(iOS 11, *) {
      return UIColor(named: "cLightGray")!
    } else {
      return .cLightGray
    }
  }

  class var cYellow: UIColor {
    if #available(iOS 11, *) {
      return UIColor(named: "cYellow")!
    } else {
      return .cYellow
    }
  }
}
