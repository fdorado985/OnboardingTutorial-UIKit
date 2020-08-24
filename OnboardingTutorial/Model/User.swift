//
//  User.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 23/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

struct User {

  let uid: String
  let email: String
  let fullName: String
  let hasSeenOnboarding: Bool

  init(uid: String, values: [String: Any]) {
    self.uid = uid
    self.email = values["email"] as? String ?? ""
    self.fullName = values["fullName"] as? String ?? ""
    self.hasSeenOnboarding = values["hasSeenOnboarding"] as? Bool ?? false
  }
}
