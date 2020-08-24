//
//  OnboardingViewModel.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 23/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

struct OnboardingViewModel {

  private let itemCount: Int

  init(itemCount: Int) {
    self.itemCount = itemCount
  }

  func shouldShowGetStartedButton(at index: Int) -> Bool {
    return index == itemCount - 1
  }
}
