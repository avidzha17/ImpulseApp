//
//  StartPresenter.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 05.10.2022.
//

import Foundation

protocol StartPresenterInput {
  func startButtonTapped()
  func viewDidLoad()
}

final class StartPresenter {
  
  weak var vc: StartViewControllerInput!
  var coordinator: OnboardingCoordinatorInput!
}

// MARK: - StartPresenterInput

extension StartPresenter: StartPresenterInput {
  
  func viewDidLoad() {
    vc.setupTextValues(StartTextValues(start: "Start"))
  }
  
  
  func startButtonTapped() {
    coordinator.showCarousel()
  }
}
