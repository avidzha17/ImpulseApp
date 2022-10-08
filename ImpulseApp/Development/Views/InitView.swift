//
//  InitView.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 04.10.2022.
//

import UIKit

class InitView: UIView {
  
  // MARK: - Constructors
  
  init() {
    super.init(frame: .zero)
    initConfigure()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initConfigure()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initConfigure()
  }
  
  // MARK: - Public methods
  
  public func initConfigure() {}
}
