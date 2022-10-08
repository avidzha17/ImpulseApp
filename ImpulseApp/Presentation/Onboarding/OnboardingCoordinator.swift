//
//  OnboardingCoordinator.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 04.10.2022.
//

import Foundation

protocol OnboardingCoordinatorInput: AnyObject {
  func showCarousel()
  func showTimer()
  func hideTimer()
}

class OnboardingCoordinator: Coordinator {
  
  // MARK: - Life cycle
  
  override func start() {
    showStartViewController()
  }
  
  // MARK: - Private
  
  private func showStartViewController() {
    let vc = StartConfigurator.configureVC(with: self)
    navigationController.pushViewController(vc, animated: true)
  }
  
  private func showCarouselViewController() {
    let vc = CarouselConfigurator.configureVC(with: self)
    navigationController.pushViewController(vc, animated: true)
  }
  
  private func showTimerViewController() {
    let vc = TimerConfigurator.configureVC(with: self)
    vc.modalPresentationStyle = .overCurrentContext
    navigationController.present(vc, animated: true)
  }
}

// MARK: - Private

extension OnboardingCoordinator: OnboardingCoordinatorInput {
  
  func showCarousel() {
    showCarouselViewController()
  }
  
  func showTimer() {
    showTimerViewController()
  }
  
  func hideTimer() {
    navigationController.dismiss(animated: true)
  }
}
