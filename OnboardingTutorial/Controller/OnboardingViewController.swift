//
//  OnboardingViewController.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 22/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation
import paper_onboarding

class OnboardingViewController: UIViewController {

  // MARK: - Properties

  private var onboardingItems = [OnboardingItemInfo]()
  private var onboardingView = PaperOnboarding()

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }

  // MARK: - Methods
}

// MARK: - PaperOnboardingDataSource

extension OnboardingViewController: PaperOnboardingDataSource {

  func onboardingItemsCount() -> Int {
    return onboardingItems.count
  }

  func onboardingItem(at index: Int) -> OnboardingItemInfo {
    return onboardingItems[index]
  }
}

// MARK: - Setup View

extension OnboardingViewController {

  private func configureViewController() {
    setupLayouts()
  }

  private func setupLayouts() {
    configureOnboardingView()
  }

  private func configureOnboardingView() {
    view.addSubview(onboardingView)
    onboardingView.fillSuperview()
    configureOnboardingDataSource()
  }

  private func configureOnboardingDataSource() {
    let item1 = OnboardingItemInfo(
      informationImage: #imageLiteral(resourceName: "baseline_insert_chart_white_48pt").withRenderingMode(.alwaysOriginal),
      title: "Metrics", description: "Some description here...",
      pageIcon: UIImage(), color: .systemPurple,
      titleColor: .white, descriptionColor: .white,
      titleFont: .boldSystemFont(ofSize: 24), descriptionFont: .systemFont(ofSize: 16)
    )

    onboardingItems.append(item1)
    onboardingItems.append(item1)
    onboardingItems.append(item1)

    onboardingView.dataSource = self
    onboardingView.reloadInputViews()
  }
}
