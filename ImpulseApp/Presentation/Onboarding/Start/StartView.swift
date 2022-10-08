//
//  StartView.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 04.10.2022.
//

import UIKit

protocol StartViewDelegate: AnyObject {
  func startButtonTapped()
}
 
class StartView: InitView {
  
  // MARK: - UI elements
  
  private let startButton = CommonButton()
  
  weak var delegate: StartViewDelegate?
  
  // MARK: - Public
  
  func configure(startText: String) {
    startButton.setTitle(startText, for: .normal)
  }
  
  // MARK: - Configuration
  
  override func initConfigure() {
    super.initConfigure()
    configureSelf()
    configureStartButton()
    configureActions()
  }
  
  private func configureSelf() {
    backgroundColor = UIConstants.backgroundColor
  }
  
  private func configureStartButton() {
    startButton.translatesAutoresizingMaskIntoConstraints = false
    addSubview(startButton)
    NSLayoutConstraint.activate([
      startButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      startButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
      startButton.heightAnchor.constraint(equalToConstant: UIConstants.StartButton.height),
      startButton.widthAnchor.constraint(equalToConstant: UIConstants.StartButton.width)
    ])
  }
  
  // MARK: - Actions
  
  private func configureActions() {
    startButton.addTarget(self,
                          action: #selector(startButtonTapped),
                          for: .touchUpInside)
  }
  
  @objc private func startButtonTapped() {
    delegate?.startButtonTapped()
  }
}

// MARK: - UIConstants

private enum UIConstants {
  static let backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
  
  enum StartButton {
    static let height = CGFloat(52)
    static let width = CGFloat(244)
  }
}
