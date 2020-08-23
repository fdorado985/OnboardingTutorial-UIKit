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
  private let getStartedButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Get Started", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 24)
    button.addTarget(self, action: #selector(getStartedButtonDidTap), for: .touchUpInside)
    return button
  }()

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
  }

  // MARK: - Actions

  @objc private func getStartedButtonDidTap(_ sender: UIButton) {

  }

  // MARK: - Methods

  private func animateGetStartedButton(_ shouldShow: Bool) {
    UIView.animate(withDuration: 0.5) {
      self.getStartedButton.alpha = shouldShow ? 1 : 0
    }
  }
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

// MARK: -

extension OnboardingViewController: PaperOnboardingDelegate {

  func onboardingWillTransitonToIndex(_ index: Int) {
    let shouldShowGetStartedButton = index == onboardingItems.count - 1
    animateGetStartedButton(shouldShowGetStartedButton)
  }
}

// MARK: - Setup View

extension OnboardingViewController {

  private func configureViewController() {
    setupLayouts()
  }

  private func setupLayouts() {
    configureOnboardingView()
    configureGetStartedButton()
  }

  private func configureOnboardingView() {
    view.addSubview(onboardingView)
    onboardingView.fillSuperview()
    configureOnboardingDataSource()
  }

  private func configureOnboardingDataSource() {
    let item1 = OnboardingItemInfo(
      informationImage: #imageLiteral(resourceName: "baseline_insert_chart_white_48pt").withRenderingMode(.alwaysOriginal),
      title: OT_ONBOARDINGVC_METRICS_TITLE, description: OT_ONBOARDINGVC_METRICS_DESCRIPTION,
      pageIcon: UIImage(), color: .systemPurple,
      titleColor: .white, descriptionColor: .white,
      titleFont: .boldSystemFont(ofSize: 24), descriptionFont: .systemFont(ofSize: 16)
    )

    let item2 = OnboardingItemInfo(
      informationImage: #imageLiteral(resourceName: "baseline_dashboard_white_48pt").withRenderingMode(.alwaysOriginal),
      title: OT_ONBOARDINGVC_DASHBOARD_TITLE, description: OT_ONBOARDINGVC_DASHBOARD_DESCRIPTION,
      pageIcon: UIImage(), color: .systemBlue,
      titleColor: .white, descriptionColor: .white,
      titleFont: .boldSystemFont(ofSize: 24), descriptionFont: .systemFont(ofSize: 16)
    )

    let item3 = OnboardingItemInfo(
      informationImage: #imageLiteral(resourceName: "baseline_notifications_active_white_48pt").withRenderingMode(.alwaysOriginal),
      title: OT_ONBOARDINGVC_NOTIFICATIONS_TITLE, description: OT_ONBOARDINGVC_NOTIFICATIONS_DESCRIPTION,
      pageIcon: UIImage(), color: .systemPink,
      titleColor: .white, descriptionColor: .white,
      titleFont: .boldSystemFont(ofSize: 24), descriptionFont: .systemFont(ofSize: 16)
    )

    onboardingItems.append(item1)
    onboardingItems.append(item2)
    onboardingItems.append(item3)

    onboardingView.dataSource = self
    onboardingView.delegate = self
    onboardingView.reloadInputViews()
  }

  private func configureGetStartedButton() {
    view.addSubview(getStartedButton)
    getStartedButton.centerX(inView: view)
    getStartedButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 128)
  }
}
