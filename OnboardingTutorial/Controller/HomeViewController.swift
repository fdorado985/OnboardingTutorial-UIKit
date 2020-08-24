//
//  HomeViewController.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {

  // MARK: - View Properties

  private let welcomeLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.numberOfLines = 2
    label.textAlignment = .center
    label.alpha = 0
    label.font = .systemFont(ofSize: 28)
    label.text = "Welcome"
    return label
  }()

  // MARK: - Properties

  private var user: User? {
    didSet {
      if let user = user {
        showWelcomeMessage(user)
        if !user.hasSeenOnboarding {
          presentOnboardingViewController()
        }
      }
    }
  }

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    authenticateUser()
  }

  // MARK: - Actions

  @objc func navigationLeftBarButtonItemDidTap(_ sender: UIBarButtonItem) {
    showLogoutAlert()
  }

  // MARK: - Methods

  private func authenticateUser() {
    if Auth.auth().currentUser?.uid == nil {
      DispatchQueue.main.async {
        self.presentLoginViewController()
      }
    } else {
      fetchUser()
    }
  }

  private func fetchUser() {
    OTService.fetchUser { [weak self] user in
      guard let self = self else { return }
      self.user = user
    }
  }

  private func showLogoutAlert() {
    let alert = UIAlertController(
      title: nil,
      message: "Are you sure you want to log out?",
      preferredStyle: .actionSheet
    )

    alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
      guard let self = self else { return }
      self.logout()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    present(alert, animated: true)
  }

  private func presentLoginViewController() {
    let loginVC = LoginViewController()
    let navController = UINavigationController(rootViewController: loginVC)
    navController.modalPresentationStyle = .fullScreen
    loginVC.delegate = self
    self.present(navController, animated: true)
  }

  private func presentOnboardingViewController() {
    let onboardingVC = OnboardingViewController()
    onboardingVC.modalPresentationStyle = .fullScreen
    onboardingVC.delegate = self
    present(onboardingVC, animated: true)
  }

  private func showWelcomeMessage(_ user: User) {
    welcomeLabel.text = "Welcome\n\(user.fullName)!"
    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }
      self.welcomeLabel.alpha = 1
    }
  }

  private func logout() {
    do {
      try Auth.auth().signOut()
      presentLoginViewController()
    } catch {
      print("Error: \(error.localizedDescription)")
    }
  }
}

// MARK: - OnboardingDelegate

extension HomeViewController: OnboardingDelegate {

  func onboardingControllerDidDismiss(_ viewController: OnboardingViewController) {
    viewController.dismiss(animated: true)
    OTService.updateUserValuesOnDatabase { [weak self] (error, _) in
      guard let self = self else { return }
      if let error = error {
        print("Error: \(#function) \(error.localizedDescription)")
        return
      }

      self.user?.hasSeenOnboarding.toggle()
    }
  }
}

// MARK: - AuthenticationDelegate

extension HomeViewController: AuthenticationDelegate {

  func authenticationDidSucceded(_ viewController: UIViewController) {
    viewController.dismiss(animated: true)
    authenticateUser()
  }
}

// MARK: - Setup View

extension HomeViewController {

  private func configureViewController() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.barStyle = .black
    navigationItem.title = "Firebase Login"
    let image = UIImage(systemName: "arrow.left")
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: image,
      style: .plain,
      target: self,
      action: #selector(navigationLeftBarButtonItemDidTap)
    )
    navigationItem.leftBarButtonItem?.tintColor = .white
    configureBackground()
    setupLayouts()
  }

  private func setupLayouts() {
    configureWelcomeLabel()
  }

  private func configureWelcomeLabel() {
    view.addSubview(welcomeLabel)
    welcomeLabel.centerY(inView: view)
    welcomeLabel.anchor(
      left: view.safeAreaLayoutGuide.leftAnchor,
      right: view.safeAreaLayoutGuide.rightAnchor,
      paddingLeft: 16,
      paddingRight: 16
    )
  }
}
