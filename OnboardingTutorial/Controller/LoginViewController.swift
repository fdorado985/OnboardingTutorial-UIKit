//
//  LoginViewController.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

  // MARK: - Properties

  private let iconImageView = UIImageView(image: #imageLiteral(resourceName: "firebase-logo"))
  private let emailTextField = OTTextField(placeholder: "Email")
  private let passwordTextField = OTTextField(placeholder: "Password", isSecureTextEntry: true)
  private let separatorView = OTSeparatorView()

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

  private let forgotPasswordButton: UIButton = {
    let button = UIButton(type: .system)

    let regularAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.87),
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
    ]
    let attributedTitle = NSMutableAttributedString(string: "Forgot your password? ", attributes: regularAttributes)

    let boldAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.87),
      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)
    ]
    attributedTitle.append(NSAttributedString(string: "Get help signing in.", attributes: boldAttributes))

    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(forgotPasswordButtonDidTap), for: .touchUpInside)
    return button
  }()

  private let googleLoginButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "btn_google_light_pressed_ios").withRenderingMode(.alwaysOriginal), for: .normal)
    button.setTitle("  Log in with Google", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 16)
    button.addTarget(self, action: #selector(googleLoginButtonDidTap), for: .touchUpInside)
    return button
  }()

  private let signUpButton: UIButton = {
    let button = UIButton(type: .system)

    let regularAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.87),
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
    ]
    let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: regularAttributes)

    let boldAttributes = [
      NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.87),
      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
    ]
    attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: boldAttributes))

    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
    return button
  }()

  private var viewModel = LoginViewModel()

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }

  // MARK: - Actions

  @objc private func loginButtonDidTap(_ sender: UIButton) {
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }

    loginUser(email, password)
  }

  @objc private func forgotPasswordButtonDidTap(_ sender: UIButton) {
    let resetPasswordVC = ResetPasswordViewController()
    navigationController?.pushViewController(resetPasswordVC, animated: true)
  }

  @objc private func googleLoginButtonDidTap(_ sender: UIButton) {
    GIDSignIn.sharedInstance()?.signIn()
  }

  @objc private func signUpButtonDidTap(_ sender: UIButton) {
    let signUpVC = SignUpViewController()
    navigationController?.pushViewController(signUpVC, animated: true)
  }

  @objc private func textDidChange(_ sender: UITextField) {
    if sender === emailTextField {
      viewModel.email = sender.text
    } else if sender === passwordTextField {
      viewModel.password = sender.text
    }

    updateForm()
  }

  // MARK: - Methods

  private func loginUser(_ email: String, _ password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] (_, error) in
      guard let self = self else { return }
      if let error = error {
        print("Error: \(error.localizedDescription)")
        return
      }

      self.dismiss(animated: true)
    }
  }
}

// MARK: - FormViewModel

extension LoginViewController: FormViewModel {

  func updateForm() {
    loginButton.isEnabled = viewModel.shouldEnableButton
    loginButton.backgroundColor = viewModel.buttonBackgroundColor
    loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}

// MARK: - GID SignIn Delegate

extension LoginViewController: GIDSignInDelegate {

  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

  }
}

// MARK: - Configure View

extension LoginViewController {

  private func configureViewController() {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    configureBackground()
    setupLayouts()
  }

  private func setupLayouts() {
    configureIconImageView()
    configureLoginFields()
    configureAlternativeLoginFields()
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
      emailTextField,
      passwordTextField,
      loginButton
    ])
    stackView.axis = .vertical
    stackView.spacing = 20

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

  private func configureAlternativeLoginFields() {
    let stackView = UIStackView(arrangedSubviews: [
      forgotPasswordButton,
      separatorView,
      googleLoginButton
    ])
    stackView.axis = .vertical
    stackView.spacing = 20

    GIDSignIn.sharedInstance()?.presentingViewController = self
    GIDSignIn.sharedInstance()?.delegate = self

    view.addSubview(stackView)
    stackView.anchor(
      top: loginButton.bottomAnchor,
      left: view.leftAnchor,
      right: view.rightAnchor,
      paddingTop: 24,
      paddingLeft: 32,
      paddingRight: 32
    )
  }

  private func configureSignUpButton() {
    view.addSubview(signUpButton)
    signUpButton.centerX(inView: view)
    signUpButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 16)
  }
}
