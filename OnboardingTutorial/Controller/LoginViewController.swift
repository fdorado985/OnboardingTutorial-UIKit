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

  private let emailTextField: UITextField = {
    let textField = UITextField()

    let spacer = UIView()
    spacer.setDimensions(height: 50, width: 12)
    textField.leftView = spacer
    textField.leftViewMode = .always

    textField.borderStyle = .none
    textField.textColor = .white
    textField.keyboardAppearance = .dark
    textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
    textField.setHeight(height: 50)
    textField.attributedPlaceholder = NSAttributedString(
      string: "Email",
      attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)]
    )
    return textField
  }()

  private let passwordTextField: UITextField = {
    let textField = UITextField()

    let spacer = UIView()
    spacer.setDimensions(height: 50, width: 12)
    textField.leftView = spacer
    textField.leftViewMode = .always

    textField.borderStyle = .none
    textField.textColor = .white
    textField.keyboardAppearance = .dark
    textField.isSecureTextEntry = true
    textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
    textField.setHeight(height: 50)
    textField.attributedPlaceholder = NSAttributedString(
      string: "Password",
      attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)]
    )
    return textField
  }()

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
    configureLoginFields()
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

  private func configureLoginFields() {
    let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
    stackView.axis = .vertical
    stackView.spacing = 20
    stackView.distribution = .fillEqually

    view.addSubview(stackView)
    stackView.anchor(
      top: iconImageView.bottomAnchor,
      left: view.leftAnchor,
      right: view.rightAnchor,
      paddingTop: 32,
      paddingLeft: 32,
      paddingRight: 32
    )
  }
}
