//
//  CarouselViewController.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 05.10.2022.
//

import UIKit

protocol CarouselViewControllerInput: AnyObject {
  func setupTextValues(_ values: CarouselTextValues)
  func updateNextButtonTitle(_ title: String)
  func presentAlert(alert: UIAlertController)
}

class CarouselViewController: UIViewController {
  
  var presenter: CarouselPresenterInput!
  
  private let selfView = CarouselView()
  
  override func loadView() {
    self.view = selfView
  }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
    configureSelfView()
    configureNavBar()
  }
  
  // MARK: - Configuration
  
  private func configureNavBar() {
    navigationItem.hidesBackButton = true
  }
  
  private func configureSelfView() {
    selfView.delegate = self
  }
}

// MARK: - CarouselViewControllerInput

extension CarouselViewController: CarouselViewControllerInput {
  func setupTextValues(_ values: CarouselTextValues) {
    selfView.configure(firstPageText: (title: values.firstPageText.title,
                                       info: values.firstPageText.info),
                       secondPageText: (title: values.secondPageText.title,
                                        info: values.secondPageText.info),
                       thirdPageText: (title: values.thirdPageText.title,
                                       info: values.thirdPageText.info),
                       nextButtonText: values.nextButtonText)
  }
  
  func updateNextButtonTitle(_ title: String) {
    selfView.updateNextButtonTitle(title)
  }
  
  func presentAlert(alert: UIAlertController) {
    present(alert, animated: true)
  }
}

// MARK: - CarouselViewDelegate

extension CarouselViewController: CarouselViewDelegate {
  func lastPageIsShown() {
    presenter.lastPageIsShown()
  }
  
  func lastPageNextButtonTapped() {
    presenter.lastPageNextButtonTapped()
  }
}

struct CarouselTextValues {
  let firstPageText: CarouselPageViewStrings
  let secondPageText: CarouselPageViewStrings
  let thirdPageText: CarouselPageViewStrings
  let nextButtonText: String
}
