//
//  StartViewController.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 04.10.2022.
//

import UIKit

protocol StartViewControllerInput: AnyObject {
  func setupTextValues(_ values: StartTextValues)
}

class StartViewController: UIViewController {
  
  var presenter: StartPresenterInput!
  
  private let selfView = StartView()
  
  override func loadView() {
    self.view = selfView
  }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
    configureNavBar()
    configureSelfView()
  }
  
  // MARK: - Configuration
  
  private func configureSelfView() {
    selfView.delegate = self
  }
  
  private func configureNavBar() {
    navigationItem.hidesBackButton = true
  }
}

// MARK: - StartViewDelegate

extension StartViewController: StartViewControllerInput {
  func setupTextValues(_ values: StartTextValues) {
    selfView.configure(startText: values.start)
  }
}

// MARK: - StartViewDelegate

extension StartViewController: StartViewDelegate {
  func startButtonTapped() {
    presenter.startButtonTapped()
  }
}

struct StartTextValues {
  let start: String
}
