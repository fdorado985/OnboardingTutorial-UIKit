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

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    authenticateUser()
  }

  // MARK: - Actions

  @objc func navigationLeftBarButtonItemDidTap(_ sender: UIBarButtonItem) {
    logout()
  }

  // MARK: - Methods

  private func authenticateUser() {
    if Auth.auth().currentUser?.uid == nil {
      DispatchQueue.main.async {
        let loginVC = UINavigationController(rootViewController: LoginViewController())
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)

      }
    } else {

    }
  }

  private func logout() {
    do {
      try Auth.auth().signOut()
    } catch {
      print("Error: \(error.localizedDescription)")
    }
  }
}

// MARK: - Setup View

extension HomeViewController {

  private func configureViewController() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.barStyle = .black
    navigationItem.title = "Firebase Login"
    let image = UIImage(systemName: "arrow.left")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(navigationLeftBarButtonItemDidTap))
    configureBackground()
  }
}
