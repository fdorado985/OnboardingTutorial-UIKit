//
//  LoginViewModel.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

struct LoginViewModel {

  var email: String?
  var password: String?

  var formIsValid: Bool {
    return email?.isEmpty == false && password?.isEmpty == false
  }
}
