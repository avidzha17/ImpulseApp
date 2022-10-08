//
//  StartConfigurator.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 06.10.2022.
//

import Foundation

struct StartConfigurator {
  
  static func configureVC(with coordinator: OnboardingCoordinatorInput) -> StartViewController {
    let viewController = StartViewController()
    let presenter = StartPresenter()
    viewController.presenter = presenter
    presenter.vc = viewController
    presenter.coordinator = coordinator
    return viewController
  }
}
