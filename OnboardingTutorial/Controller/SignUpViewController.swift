//
//  SignUpViewController.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

  // MARK: - Properties

  private let iconImageView = UIImageView(image: #imageLiteral(resourceName: "firebase-logo"))
  private let fullNameTextField = OTTextField(placeholder: "Full Name")
  private let emailTextField = OTTextField(placeholder: "Email")
  private let passwordTextField = OTTextField(placeholder: "Password", isSecureTextEntry: true)

  private let signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
    button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.layer.cornerRadius = 5
    button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    button.setHeight(height: 50)
    button.isEnabled = false
    button.setTitle("Sign Up", for: .normal)
    return button
  }()

  private let loginButton: UIButton = {
    let button = UIButton(type: .system)

    let regularAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.87),
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
    ]
    let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: regularAttributes)

    let boldAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.87),
      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
    ]
    attributedTitle.append(NSAttributedString(string: "Log In", attributes: boldAttributes))

    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(logInButtonDidTap), for: .touchUpInside)
    return button
  }()

  private var viewModel = SignUpViewModel()

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }

  // MARK: - Actions

  @objc private func logInButtonDidTap(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }

  @objc private func signUpButtonDidTap(_ sender: UIButton) {
    print("DEBUG: Handle sign up...")
  }

  @objc private func textDidChange(_ sender: UITextField) {
    if sender === emailTextField {
      viewModel.email = sender.text
    } else if sender === passwordTextField {
      viewModel.password = sender.text
    } else if sender === fullNameTextField {
      viewModel.fullName = sender.text
    }

    updateForm()
  }
}

// MARK: - FormViewModel

extension SignUpViewController: FormViewModel {

  func updateForm() {
    signUpButton.isEnabled = viewModel.shouldEnableButton
    signUpButton.backgroundColor = viewModel.buttonBackgroundColor
    signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}

// MARK: - Configure View

extension SignUpViewController {

  private func configureViewController() {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    configureBackground()
    setupLayouts()
  }

  private func setupLayouts() {
    configureIconImageView()
    configureLoginFields()
    configureSignUpButton()
  }

  private func configureIconImageView() {
    view.addSubview(iconImageView)
    iconImageView.centerX(inView: view)
    iconImageView.setDimensions(height: 120, width: 120)
    iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
  }

  private func configureLoginFields() {
    let stackView = UIStackView(arrangedSubviews: [
      fullNameTextField,
      emailTextField,
      passwordTextField,
      signUpButton
    ])
    stackView.axis = .vertical
    stackView.spacing = 20

    fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

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

  private func configureSignUpButton() {
    view.addSubview(loginButton)
    loginButton.centerX(inView: view)
    loginButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 16)
  }
}
