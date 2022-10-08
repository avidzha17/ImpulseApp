//
//  TimerConfigurator.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 07.10.2022.
//

import Foundation

struct TimerConfigurator {
  
  static func configureVC(with coordinator: OnboardingCoordinatorInput) -> TimerViewController {
    let viewController = TimerViewController()
    let presenter = TimerPresenter()
    viewController.presenter = presenter
    presenter.vc = viewController
    presenter.coordinator = coordinator
    presenter.userDefaultsService = UserDefaultsService.shared
    return viewController
  }
}
