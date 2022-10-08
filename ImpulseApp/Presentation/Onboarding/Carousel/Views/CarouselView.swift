//
//  CarouselView.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 05.10.2022.
//

import UIKit

typealias CarouselPageViewStrings = (title: String, info: String)

protocol CarouselViewDelegate: AnyObject {
  func lastPageIsShown()
  func lastPageNextButtonTapped()
}

class CarouselView: InitView {
  
  // MARK: - UI elements
  
  private let scrollView = UIScrollView()
  private let scrollStackView = UIStackView()
  private let firstPageView = CarouselPageView()
  private let secondPageView = CarouselPageView()
  private let thirdPageView = CarouselPageView()
  private let pageControl = UIPageControl()
  private let nextButton = CommonButton()
  
  // MARK: - Public
  
  weak var delegate: CarouselViewDelegate?
  
  func configure(firstPageText: CarouselPageViewStrings,
                 secondPageText: CarouselPageViewStrings,
                 thirdPageText: CarouselPageViewStrings,
                 nextButtonText: String) {
    firstPageView.configure(image: UIConstants.Images.firstImage,
                            titleText: firstPageText.title,
                            infoText: firstPageText.info)
    secondPageView.configure(image: UIConstants.Images.secondImage,
                            titleText: secondPageText.title,
                            infoText: secondPageText.info)
    thirdPageView.configure(image: UIConstants.Images.thirdImage,
                            titleText: thirdPageText.title,
                            infoText: thirdPageText.info)
    nextButton.setTitle(nextButtonText, for: .normal)
  }
  
  func updateNextButtonTitle(_ title: String) {
    nextButton.setTitle(title, for: .normal)
  }
  
  // MARK: - Configuration
  
  override func initConfigure() {
    super.initConfigure()
    configureSelf()
    configureScrollView()
    configureScrollStackView()
    configurePageView(firstPageView)
    configurePageView(secondPageView)
    configurePageView(thirdPageView)
    configureNextButton()
    configurePageControl()
    configureActions()
  }
  
  private func configureSelf() {
    backgroundColor = UIConstants.backgroundColor
  }
  
  private func configureScrollView() {
    scrollView.delegate = self
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isPagingEnabled = true
    addSubview(scrollView)
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                      constant: UIConstants.ScrollView.top),
      scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
    ])
  }
  
  private func configureScrollStackView() {
    scrollStackView.translatesAutoresizingMaskIntoConstraints = false
    scrollStackView.axis = .horizontal
    scrollStackView.alignment = .top
    scrollView.addSubview(scrollStackView)
    NSLayoutConstraint.activate([
      scrollStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      scrollStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      scrollStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      scrollStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      scrollStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
    ])
  }
  
  private func configurePageView(_ view: CarouselPageView) {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    view.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(view)
    NSLayoutConstraint.activate([
      view.leadingAnchor.constraint(equalTo: container.leadingAnchor,
                                              constant: UIConstants.PageContainer.horizontalInset),
      view.topAnchor.constraint(equalTo: container.topAnchor),
      view.trailingAnchor.constraint(equalTo: container.trailingAnchor,
                                               constant: -UIConstants.PageContainer.horizontalInset),
      view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
    ])
    
    scrollStackView.addArrangedSubview(container)
    NSLayoutConstraint.activate([
      container.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
  }
  
  private func configurePageControl() {
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.pageIndicatorTintColor = UIConstants.PageControl.tintColor
    pageControl.currentPageIndicatorTintColor = UIConstants.PageControl.currentPageTintColor
    pageControl.numberOfPages = UIConstants.PageControl.numberOfPages
    addSubview(pageControl)
    NSLayoutConstraint.activate([
      pageControl.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      pageControl.topAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor,
                                       constant: UIConstants.PageControl.top),
      pageControl.bottomAnchor.constraint(greaterThanOrEqualTo: nextButton.topAnchor,
                                       constant: UIConstants.PageControl.bottom)
    ])
  }
  
  private func configureNextButton() {
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    addSubview(nextButton)
    NSLayoutConstraint.activate([
      nextButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                          constant: UIConstants.StartButton.horizontalInset),
      nextButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                          constant: -UIConstants.StartButton.horizontalInset),
      nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                         constant: UIConstants.StartButton.bottom),
      nextButton.heightAnchor.constraint(equalToConstant: UIConstants.StartButton.height),
    ])
  }
  
  // MARK: - Actions
  
  private func configureActions() {
    pageControl.addTarget(self,
                          action: #selector(changePage),
                          for: .valueChanged)
    nextButton.addTarget(self,
                         action: #selector(nextButtonTapped),
                         for: .touchUpInside)
  }
    
  @objc private func changePage(sender: AnyObject) {
    let x = (CGFloat(pageControl.currentPage) * scrollView.frame.size.width)
    scrollView.setContentOffset(CGPoint(x: x, y: 0),
                                animated: true)
    lastPageChecking()
  }
  
  @objc private func nextButtonTapped() {
    pageControl.currentPage = pageControl.currentPage + 1
    let x = (CGFloat(pageControl.currentPage) * scrollView.frame.size.width)
    scrollView.setContentOffset(CGPoint(x: x, y: 0),
                                animated: true)
    lastPageChecking()
  }
  
  @objc private func lastPageNextButtonTapped() {
    delegate?.lastPageNextButtonTapped()
  }
  
  // MARK: - Private
  
  private func lastPageChecking() {
    guard pageControl.currentPage < pageControl.numberOfPages - 1 else {
      delegate?.lastPageIsShown()
      nextButton.removeTarget(self,
                              action: #selector(nextButtonTapped),
                              for: .touchUpInside)
      nextButton.addTarget(self,
                           action: #selector(lastPageNextButtonTapped),
                           for: .touchUpInside)
      return
    }
  }
}

// MARK: - UIScrollViewDelegate

extension CarouselView: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
    pageControl.currentPage = Int(pageNumber)
    lastPageChecking()
  }
}

// MARK: - UIConstants

private enum UIConstants {
  static let backgroundColor = UIColor(red: 0.129, green: 0.129, blue: 0.129, alpha: 1)
  
  enum ScrollView {
    static let top = CGFloat(120)
  }
  
  enum StartButton {
    static let height = CGFloat(52)
    static let bottom = CGFloat(-58)
    static let horizontalInset = CGFloat(24)
  }
  
  enum PageContainer {
    static let horizontalInset = CGFloat(28)
  }
  
  enum PageControl {
    static let tintColor = UIColor.white.withAlphaComponent(0.4)
    static let currentPageTintColor = UIColor.white
    static let numberOfPages = 3
    static let top = CGFloat(27)
    static let bottom = CGFloat(-28)
  }
  
  enum Images {
    static let firstImage = UIImage.init(named: "carouselFirst")!
    static let secondImage = UIImage.init(named: "carouselSecond")!
    static let thirdImage = UIImage.init(named: "carouselThird")!
  }
}

