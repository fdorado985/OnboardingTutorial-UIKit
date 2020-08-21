//
//  LoginViewModel.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

struct LoginViewModel {

  var email: String?
  var password: String?

  var formIsValid: Bool {
    return email?.isEmpty == false && password?.isEmpty == false
  }

  var shouldEnableButton: Bool {
    return formIsValid
  }

  var buttonTitleColor: UIColor {
    return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
  }

  var buttonBackgroundColor: UIColor {
    let enabledPurple = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    let disablePurple = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    return formIsValid ? enabledPurple : disablePurple
  }
}
