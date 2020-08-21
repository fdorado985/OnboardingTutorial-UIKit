//
//  ResetPasswordViewController.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

  // MARK: - Properties

  private let iconImageView = UIImageView(image: #imageLiteral(resourceName: "firebase-logo"))
  private let emailTextField = OTTextField(placeholder: "Email")

  private let sendResetLinkButton: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(sendResetLinkButtonDidTap), for: .touchUpInside)
    button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.layer.cornerRadius = 5
    button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    button.setHeight(height: 50)
    button.isEnabled = false
    button.setTitle("Send Reset Link", for: .normal)
    return button
  }()

  private let backButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .white
    button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    return button
  }()

  private var viewModel = ResetPasswordViewModel()

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }

  // MARK: - Actions

  @objc private func sendResetLinkButtonDidTap(_ sender: UIButton) {
  }

  @objc private func backButtonDidTap(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }

  @objc private func textDidChange(_ sender: UITextField) {
    if sender === emailTextField {
      viewModel.email = sender.text
    }

    updateForm()
  }
}

// MARK: - FormViewModel

extension ResetPasswordViewController: FormViewModel {

  func updateForm() {
    sendResetLinkButton.isEnabled = viewModel.shouldEnableButton
    sendResetLinkButton.backgroundColor = viewModel.buttonBackgroundColor
    sendResetLinkButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}

// MARK: - Configure View

extension ResetPasswordViewController {

  private func configureViewController() {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    configureBackground()
    setupLayouts()
  }

  private func setupLayouts() {
    configureIconImageView()
    configureLoginFields()
    configureBackButton()
  }

  private func configureIconImageView() {
    view.addSubview(iconImageView)
    iconImageView.centerX(inView: view)
    iconImageView.setDimensions(height: 120, width: 120)
    iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
  }

  private func configureLoginFields() {
    let stackView = UIStackView(arrangedSubviews: [
      emailTextField,
      sendResetLinkButton
    ])
    stackView.axis = .vertical
    stackView.spacing = 20

    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

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

  private func configureBackButton() {
    view.addSubview(backButton)
    backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
  }
}
