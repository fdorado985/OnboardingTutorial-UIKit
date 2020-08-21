//
//  LoginViewController.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  // MARK: - Properties

  private let iconImageView = UIImageView(image: #imageLiteral(resourceName: "firebase-logo"))

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }
}

extension LoginViewController {

  private func configureViewController() {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    configureBackground()
    configureIconImageView()
  }

  private func configureBackground() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
    gradient.locations = [0, 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }

  private func configureIconImageView() {
    view.addSubview(iconImageView)
    iconImageView.centerX(inView: view)
    iconImageView.setDimensions(height: 120, width: 120)
    iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
  }
}
