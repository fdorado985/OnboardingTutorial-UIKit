//
//  UIViewController+Ext.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit
import JGProgressHUD

// MARK: - Background Color

extension UIViewController {

  static let hud = JGProgressHUD(style: .dark)

  func configureBackground() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
    gradient.locations = [0, 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }

  func showLoader(_ show: Bool) {
    view.endEditing(true)

    if show {
      UIViewController.hud.show(in: view)
    } else {
      UIViewController.hud.dismiss()
    }
  }
}
