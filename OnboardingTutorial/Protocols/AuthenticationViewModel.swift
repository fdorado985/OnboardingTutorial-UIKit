//
//  AuthenticationViewModel.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

protocol AuthenticationViewModel {

  var formIsValid: Bool { get }
  var shouldEnableButton: Bool { get }
  var buttonTitleColor: UIColor { get }
  var buttonBackgroundColor: UIColor { get }
}
