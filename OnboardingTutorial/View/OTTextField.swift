//
//  OTTextField.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

class OTTextField: UITextField {

  init(placeholder: String = "", isSecureTextEntry: Bool = false) {
    super.init(frame: .zero)
    configureTextField(placeholder, isSecureTextEntry)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureTextField(_ placeholder: String, _ isSecureTextEntry: Bool) {
    borderStyle = .none
    textColor = .white
    keyboardAppearance = .dark
    backgroundColor = UIColor(white: 1, alpha: 0.1)
    setHeight(height: 50)
    attributedPlaceholder = NSAttributedString(
      string: placeholder,
      attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)]
    )
    self.isSecureTextEntry = isSecureTextEntry
  }
}

extension OTTextField {

  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 12, dy: 12)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return textRect(forBounds: bounds)
  }
}
