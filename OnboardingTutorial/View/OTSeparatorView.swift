//
//  OTSeparatorView.swift
//  OnboardingTutorial
//
//  Created by Juan Francisco Dorado Torres on 21/08/20.
//  Copyright © 2020 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

class OTSeparatorView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)

    let label = UILabel()
    label.text = "OR"
    label.textColor = UIColor(white: 1, alpha: 0.87)
    label.font = UIFont.systemFont(ofSize: 14)

    addSubview(label)
    label.centerX(inView: self)
    label.centerY(inView: self)

    let divider1 = UIView()
    divider1.backgroundColor = UIColor(white: 1, alpha: 0.25)
    addSubview(divider1)
    divider1.centerY(inView: self)
    divider1.anchor(left: leftAnchor, right: label.leftAnchor, paddingLeft: 8, paddingRight: 8, height: 1)

    let divider2 = UIView()
    divider2.backgroundColor = UIColor(white: 1, alpha: 0.25)
    addSubview(divider2)
    divider2.centerY(inView: self)
    divider2.anchor(left: label.rightAnchor, right: rightAnchor, paddingLeft: 8, paddingRight: 8, height: 1)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
