//
//  TimerViewController.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 07.10.2022.
//

import UIKit

protocol TimerViewControllerInput: AnyObject {
  func setupTextValues(_ values: TimerTextValues)
  func updateTimerValue(_ value: String)
  func updateContinueButtonAvailability(_ value: Bool)
  func startAnimation(with duration: Int)
}

class TimerViewController: UIViewController {
  
  var presenter: TimerPresenterInput!
  
  private let selfView = TimerView()
  
  override func loadView() {
    self.view = selfView
  }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
    configureSelfView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presenter.viewDidAppear()
  }
  
  private func configureSelfView() {
    selfView.delegate = self
  }
}

// MARK: - TimerViewControllerInput

extension TimerViewController: TimerViewControllerInput {
  
  func setupTextValues(_ values: TimerTextValues) {
    selfView.configure(startTimerText: values.startTimerText,
                       continueText: values.continueButtonTitle)
  }
  
  func updateTimerValue(_ value: String) {
    selfView.updateTimerValue(value)
  }
  
  func startAnimation(with duration: Int) {
    selfView.startAnimation(with: duration)
  }
  
  func updateContinueButtonAvailability(_ value: Bool) {
    selfView.setContinueButtonAvailability(to: value)
  }
}

// MARK: - TimerViewDelegate

extension TimerViewController: TimerViewDelegate {
  func continueButtonTapped() {
    presenter.continueButtonTapped()
  }
}

struct TimerTextValues {
  let startTimerText: String
  let continueButtonTitle: String
}
