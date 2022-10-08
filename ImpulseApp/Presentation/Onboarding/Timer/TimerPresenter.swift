//
//  TimerPresenter.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 07.10.2022.
//

import Foundation

protocol TimerPresenterInput {
  func viewDidLoad()
  func viewDidAppear()
  func continueButtonTapped()
}

final class TimerPresenter {
  
  weak var vc: TimerViewControllerInput!
  var coordinator: OnboardingCoordinatorInput!
  var userDefaultsService: UserDefaultsService!
  
  // MARK: - Private properties
  
  private let startSecondsValue = 60
  private var currentSecondsCount = 60
  private var timer: Timer?
  
  // MARK: - Private
  
  private func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1,
                                 target: self,
                                 selector: #selector(handleTimerTick),
                                 userInfo: nil,
                                 repeats: true)
  }
  
  @objc private func handleTimerTick() {
    let string = getTimerString(by: currentSecondsCount)
    vc.updateTimerValue(string)
    if currentSecondsCount == 0 {
      timer?.invalidate()
      vc.updateContinueButtonAvailability(true)
    }
    currentSecondsCount -= 1
  }
  
  func getTimerString(by value: Int) -> String {
    let minutes = value / 60
    let seconds = value % 60
    let minutesValue = minutes < 10 ? "0" + String(minutes) : String(minutes)
    let secondsValue = seconds < 10 ? "0" + String(seconds) : String(seconds)
    return minutesValue + ":" + secondsValue
  }
}

// MARK: - TimerPresenterInput

extension TimerPresenter: TimerPresenterInput {
  
  func viewDidLoad() {
    startTimer()
    let textValues = TimerTextValues(startTimerText: getTimerString(by: startSecondsValue),
                                     continueButtonTitle: "Continue")
    vc.setupTextValues(textValues)
    vc.updateContinueButtonAvailability(false)
  }
  
  func viewDidAppear() {
    vc.startAnimation(with: startSecondsValue)
  }
  
  func continueButtonTapped() {
    userDefaultsService.isTimerAlreadyShown = true
    coordinator.hideTimer()
  }
}
