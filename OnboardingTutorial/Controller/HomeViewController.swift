//
//  HomeViewController.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

  // MARK: - Properties

  private var shouldShowOnboardingController = true

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
      if shouldShowOnboardingController {
        presentOnboardingViewController()
      }
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
    let loginVC = UINavigationController(rootViewController: LoginViewController())
    loginVC.modalPresentationStyle = .fullScreen
    self.present(loginVC, animated: true)
  }

  private func presentOnboardingViewController() {
    let onboardingVC = OnboardingViewController()
    onboardingVC.modalPresentationStyle = .fullScreen
    onboardingVC.delegate = self
    present(onboardingVC, animated: true)
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
    shouldShowOnboardingController.toggle()
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
  }
}
