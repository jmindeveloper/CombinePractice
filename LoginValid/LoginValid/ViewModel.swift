//
//  ViewModel.swift
//  LoginValid
//
//  Created by J_Min on 2022/05/29.
//

import Foundation
import Combine
import UIKit

final class ViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var matchingPassword: String = ""
    
    private func emailValid() -> AnyPublisher<Bool, Never> {
        $email
            .map { email -> Bool in
                if email.contains("@"), email.contains(".") {
                    return true
                } else {
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func passwordVaild() -> AnyPublisher<Bool, Never> {
        $password
            .map { password -> Bool in
                if password.count >= 10 {
                    return true
                } else {
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func matchingPasswordValid() -> AnyPublisher<Bool, Never> {
        $matchingPassword
            .combineLatest($password)
            .map {
                if $0.0 == $0.1 {
                    return true
                } else {
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    func isValid() -> AnyPublisher<Bool, Never> {
        emailValid()
            .combineLatest(passwordVaild(), matchingPasswordValid())
            .map {
                if $0.0, $0.1, $0.2 {
                    return true
                } else {
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
}
