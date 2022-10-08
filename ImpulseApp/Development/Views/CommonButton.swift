//
//  CommonButton.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 04.10.2022.
//

import UIKit

class CommonButton: UIButton {
  
  // MARK: Life cycle
  
  init() {
    super.init(frame: .zero)
    initConfigure()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - Public
  
  func setAvailability(to value: Bool) {
    isUserInteractionEnabled = value
    backgroundColor = value ? UIConstants.backgroundColor : UIConstants.disabledBackgroundColor
    let titleColor = value ? UIConstants.titleColor : UIConstants.disableTitleColor
    setTitleColor(titleColor, for: .normal)
  }
  
  // MARK: Configuration
  
  private func initConfigure() {
    configureSelf()
  }
  
  private func configureSelf() {
    backgroundColor = UIConstants.backgroundColor
    layer.cornerRadius = UIConstants.cornerRadius
    titleLabel?.font = UIConstants.titleLabelFont
  }
}

// MARK: - UIConstants

private enum UIConstants {
  static let backgroundColor = UIColor(red: 0.937, green: 0.537, blue: 0.373, alpha: 1)
  static let disabledBackgroundColor = UIColor(red: 0.937, green: 0.537, blue: 0.373, alpha: 0.4)
  static let cornerRadius = CGFloat(10)
  static let titleLabelFont = UIFont.systemFont(ofSize: 16, weight: .bold)
  static let titleColor = UIColor.white
  static let disableTitleColor =  UIColor.white.withAlphaComponent(0.4)
}
