//
//  UserDefaultsService.swift
//  ImpulseApp
//
//  Created by Александр Хаверев on 08.10.2022.
//

import Foundation

class UserDefaultsService {
  
  static let shared = UserDefaultsService()
  
  private let isTimerAlreadyShownKey = "isTimerAlreadyShownKey"

  // MARK: - Life cycle
  
  private init() {}
  
  // MARK: - Public
  
  var isTimerAlreadyShown: Bool {
    get {
      guard UserDefaults.standard.string(forKey: isTimerAlreadyShownKey) != nil else {
        return false
      }
      return true
    }
    set {
      UserDefaults.standard.set(newValue, forKey: isTimerAlreadyShownKey)
    }
  }
}
