//
//  AppCoordinator.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 04.10.2022.
//

import UIKit.UIViewController

class AppCoordinator: BaseCoordinator {
  
  // MARK: - Private properties
  
  private let window: UIWindow
  
  // MARK: - Public properties
  
  var navigationController: UINavigationController = UINavigationController(rootViewController: UIViewController())
  weak var onboardingCoordinator: OnboardingCoordinator?
  
  // MARK: - Life cycle
  
  init(window: UIWindow) {
    window.rootViewController = navigationController
    self.window = window
  }
  
  func start() {
    showOnboarding()
  }
  
  // MARK: - Private
  
  private func showOnboarding() {
    let coordinator = OnboardingCoordinator(navigationController: navigationController)
    coordinator.start()
    onboardingCoordinator = coordinator
  }
}

