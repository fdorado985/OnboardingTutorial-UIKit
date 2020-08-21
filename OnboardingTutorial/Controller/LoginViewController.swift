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
  private let emailTextField = OTTextField(placeholder: "Email")
  private let passwordTextField = OTTextField(placeholder: "Password", isSecureTextEntry: true)
  private let loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.layer.cornerRadius = 5
    button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    button.setHeight(height: 50)
    button.isEnabled = false
    button.setTitle("Log In", for: .normal)
    return button
  }()

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }

  // MARK: - Actions

  @objc private func loginButtonDidTap(_ sender: UIButton) {
    print("DEBUG: Handle login...")
  }
}

// MARK: - Configure View

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
    let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
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
