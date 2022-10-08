//
//  CarouselPresenter.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 05.10.2022.
//

import Foundation
import UIKit.UIAlertController

protocol CarouselPresenterInput {
  func viewDidLoad()
  func lastPageIsShown()
  func lastPageNextButtonTapped()
}

final class CarouselPresenter {
  
  weak var vc: CarouselViewControllerInput!
  var coordinator: OnboardingCoordinatorInput!
  var userDefaultsService: UserDefaultsService!
  
  // MARK: - Private properties
  
  private var timerAlreadyShownAlert : UIAlertController {
    let alert = UIAlertController(title: "Thank you for your interest",
                                  message: "The functionality is under development",
                                  preferredStyle: .alert)
    alert.addAction((UIAlertAction(title: "OK",
                                   style: .cancel,
                                   handler: nil)))
    alert.overrideUserInterfaceStyle = .dark
    return alert
  }
  
  // MARK: - Private
  
  private func handleLastPageNextButtonTap() {
    if userDefaultsService.isTimerAlreadyShown {
      vc.presentAlert(alert: timerAlreadyShownAlert)
    } else {
      coordinator.showTimer()
    }
  }
}

// MARK: - CarouselViewControllerInput

extension CarouselPresenter: CarouselPresenterInput {
  
  func viewDidLoad() {
    let textValues = CarouselTextValues(firstPageText: (title: "Boost Productivity",
                                                        info: "Take your productivity to the next level"),
                                        secondPageText: (title: "Work Seamlessly",
                                                         info: "Get your work done seamlessly without interruption"),
                                        thirdPageText: (title: "Achieve Your Goals",
                                                        info: "Boosted productivity will help you achieve the desired goals"),
                                        nextButtonText: "Next")
    vc.setupTextValues(textValues)
  }
  
  func lastPageIsShown() {
    vc.updateNextButtonTitle("Continue")
  }
  
  func lastPageNextButtonTapped() {
    handleLastPageNextButtonTap()
  }
}
