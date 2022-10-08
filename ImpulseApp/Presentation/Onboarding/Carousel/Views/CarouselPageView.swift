//
//  CarouselPageView.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 05.10.2022.
//

import UIKit

class CarouselPageView: InitView {
  
  // MARK: - UI elements

  private let imageView = UIImageView()
  private let titleLabel = UILabel()
  private let infoLabel = UILabel()
  
  // MARK: - Public
  
  func configure(image: UIImage,
                 titleText: String,
                 infoText: String) {
    imageView.image = image
    titleLabel.text = titleText
    infoLabel.text = infoText
  }
  
  // MARK: - Configuration
  
  override func initConfigure() {
    super.initConfigure()
    configureImageView()
    configureTitleLabel()
    configureInfoLabel()
  }
  
  private func configureImageView() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      imageView.heightAnchor.constraint(equalToConstant: UIConstants.ImageView.height),
    ])
  }
  
  private func configureTitleLabel() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textAlignment = .center
    titleLabel.textColor = UIConstants.TitleLabel.textColor
    titleLabel.font = UIConstants.TitleLabel.font
    addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
    ])
  }
  
  private func configureInfoLabel() {
    infoLabel.translatesAutoresizingMaskIntoConstraints = false
    infoLabel.textAlignment = .center
    infoLabel.numberOfLines = 0
    infoLabel.textColor = UIConstants.InfoLabel.textColor
    infoLabel.font = UIConstants.InfoLabel.font
    addSubview(infoLabel)
    NSLayoutConstraint.activate([
      infoLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
      infoLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      infoLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - UIConstants

private enum UIConstants {
  
  enum ImageView {
    static let height = CGFloat(280)
  }
  
  enum TitleLabel {
    static let textColor = UIColor.white
    static let font = UIFont.systemFont(ofSize: 28, weight: .semibold)
  }
  
  enum InfoLabel {
    static let textColor = UIColor.white
    static let font = UIFont.systemFont(ofSize: 16, weight: .regular)
  }
}
