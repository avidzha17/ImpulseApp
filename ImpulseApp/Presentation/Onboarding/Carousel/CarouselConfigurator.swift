//
//  CarouselConfigurator.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 06.10.2022.
//

import Foundation

struct CarouselConfigurator {
  
  static func configureVC(with coordinator: OnboardingCoordinatorInput) -> CarouselViewController {
    let viewController = CarouselViewController()
    let presenter = CarouselPresenter()
    viewController.presenter = presenter
    presenter.vc = viewController
    presenter.coordinator = coordinator
    presenter.userDefaultsService = UserDefaultsService.shared
    return viewController
  }
}
