//
//  TimerView.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 07.10.2022.
//

import UIKit

protocol TimerViewDelegate: AnyObject {
  func continueButtonTapped()
}

class TimerView: InitView {
  
  // MARK: - UI elements
  
  private let timerLabel = UILabel()
  private let progressBackgroundView = UIView()
  private let progressView = UIView()
  private let continueButton = CommonButton()
  private let mainContainer = UIView()
  
  weak var delegate: TimerViewDelegate?
  
  // MARK: - Public
  
  func configure(startTimerText: String,
                 continueText: String) {
    timerLabel.text = startTimerText
    continueButton.setTitle(continueText, for: .normal)
  }
  
  func updateTimerValue(_ value: String) {
    timerLabel.text = value
  }
  
  func startAnimation(with duration: Int) {
    animateProgressView(by: duration)
  }
  
  func setContinueButtonAvailability(to value: Bool) {
    continueButton.setAvailability(to: value)
  }
  
  // MARK: - Configuration
  
  override func initConfigure() {
    super.initConfigure()
    configureSelf()
    configureMainContainer()
    configureTimerLabel()
    configureProgressBackgroundView()
    configureProgressView()
    configureContinueButton()
    configureActions()
  }
  
  private func configureSelf() {
    backgroundColor = UIConstants.backgroundColor
  }
  
  private func configureMainContainer() {
    mainContainer.translatesAutoresizingMaskIntoConstraints = false
    mainContainer.backgroundColor = UIConstants.MainContainer.backgroundColor
    mainContainer.layer.cornerRadius = UIConstants.MainContainer.cornerRadius
    addSubview(mainContainer)
    NSLayoutConstraint.activate([
      mainContainer.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      mainContainer.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
      mainContainer.heightAnchor.constraint(equalToConstant: UIConstants.MainContainer.height),
      mainContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                             constant: UIConstants.MainContainer.horizontalOffset),
      mainContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                              constant: -UIConstants.MainContainer.horizontalOffset)
    ])
  }
  
  private func configureTimerLabel() {
    timerLabel.translatesAutoresizingMaskIntoConstraints = false
    timerLabel.textAlignment = .center
    timerLabel.textColor = UIConstants.TimerLabel.textColor
    timerLabel.font = UIConstants.TimerLabel.font
    mainContainer.addSubview(timerLabel)
    NSLayoutConstraint.activate([
      timerLabel.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor,
                                          constant: UIConstants.contentHorizontalOffset),
      timerLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor,
                                      constant: UIConstants.TimerLabel.top),
      timerLabel.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor,
                                           constant: -UIConstants.contentHorizontalOffset)
    ])
  }
  
  private func configureProgressBackgroundView() {
    progressBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    progressBackgroundView.backgroundColor = UIConstants.ProgressBackgroundView.backgroundColor
    progressBackgroundView.layer.cornerRadius = UIConstants.ProgressBackgroundView.cornerRadius
    mainContainer.addSubview(progressBackgroundView)
    NSLayoutConstraint.activate([
      progressBackgroundView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor,
                                                      constant: UIConstants.contentHorizontalOffset),
      progressBackgroundView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor,
                                                  constant: UIConstants.ProgressBackgroundView.top),
      progressBackgroundView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor,
                                                       constant: -UIConstants.contentHorizontalOffset),
      progressBackgroundView.heightAnchor.constraint(equalToConstant: UIConstants.ProgressBackgroundView.height)
    ])
  }
  
  private func configureProgressView() {
    progressView.translatesAutoresizingMaskIntoConstraints = false
    progressView.backgroundColor = UIConstants.ProgressView.backgroundColor
    progressView.layer.cornerRadius = UIConstants.ProgressView.cornerRadius
    mainContainer.addSubview(progressView)
  }
  
  private func configureContinueButton() {
    continueButton.translatesAutoresizingMaskIntoConstraints = false
    mainContainer.addSubview(continueButton)
    NSLayoutConstraint.activate([
      continueButton.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor,
                                          constant: UIConstants.ContinueButton.horizontalInset),
      continueButton.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor,
                                          constant: -UIConstants.ContinueButton.horizontalInset),
      continueButton.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor,
                                         constant: UIConstants.ContinueButton.bottom),
      continueButton.heightAnchor.constraint(equalToConstant: UIConstants.ContinueButton.height),
    ])
  }
  
  // MARK: - Actions
  
  private func configureActions() {
    continueButton.addTarget(self,
                             action: #selector(continueButtonTapped),
                             for: .touchUpInside)
  }
  
  @objc private func continueButtonTapped() {
    delegate?.continueButtonTapped()
  }
  
  // MARK: - Private
  
  private func animateProgressView(by duration: Int) {
    progressView.frame = CGRect(x: progressBackgroundView.frame.origin.x,
                                y: progressBackgroundView.frame.origin.y,
                                width: 0,
                                height: UIConstants.ProgressView.height)
    UIView.animate(withDuration: TimeInterval(duration),
                   delay: 0,
                   animations: { [weak self] in
      guard let self = self else { return }
      self.progressView.frame = CGRect(x: self.progressBackgroundView.frame.origin.x,
                                       y: self.progressBackgroundView.frame.origin.y,
                                       width: self.progressBackgroundView.frame.width,
                                       height: UIConstants.ProgressView.height)
    })
  }
}

// MARK: - UIConstants

private enum UIConstants {
  static let contentHorizontalOffset = CGFloat(28)
  static let backgroundColor = UIColor.black.withAlphaComponent(0.5)
  
  enum MainContainer {
    static let backgroundColor = UIColor(red: 0.166, green: 0.169, blue: 0.175, alpha: 1)
    static let cornerRadius = CGFloat(28)
    static let height = UIScreen.main.bounds.height / 2
    static let horizontalOffset = CGFloat(24)
  }
  
  enum TimerLabel {
    static let top = CGFloat(96)
    static let textColor = UIColor.white
    static let font = UIFont.systemFont(ofSize: 68, weight: .semibold)
  }
  
  enum ProgressBackgroundView {
    static let backgroundColor = UIColor.white.withAlphaComponent(0.24)
    static let cornerRadius = height / 2
    static let height = CGFloat(8)
    static let top = CGFloat(32)
  }
  
  enum ProgressView {
    static let backgroundColor = UIColor(red: 0.937, green: 0.537, blue: 0.373, alpha: 1)
    static let cornerRadius = height / 2
    static let height = CGFloat(8)
  }
  
  enum ContinueButton {
    static let height = CGFloat(52)
    static let bottom = CGFloat(-32)
    static let horizontalInset = CGFloat(32)
  }
}
