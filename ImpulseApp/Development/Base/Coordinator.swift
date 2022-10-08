//
//  Coordinator.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 04.10.2022.
//

import UIKit.UINavigationController

protocol BaseCoordinator {
  func start()
}

class Coordinator: BaseCoordinator {
  
  var navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {}
}
