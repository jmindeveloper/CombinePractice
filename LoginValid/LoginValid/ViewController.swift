//
//  ViewController.swift
//  LoginValid
//
//  Created by J_Min on 2022/05/29.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var subscriptions = Set<AnyCancellable>()
    @Published private var isSignUpButtonEnable = false

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var matchingPasswordTextField: UITextField!
    @IBOutlet weak var SignUPButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target()
        configureCombine()
    }
    
    private func configureCombine() {
        $isSignUpButtonEnable
            .sink { [weak self] isEnable in
                if isEnable {
                    self?.SignUPButton.backgroundColor = .systemOrange
                    self?.SignUPButton.isEnabled = true
                } else {
                    self?.SignUPButton.backgroundColor = .lightGray
                    self?.SignUPButton.isEnabled = false
                }
            }.store(in: &subscriptions)
        
        viewModel.isValid()
            .assign(to: &$isSignUpButtonEnable)
    }
    
    private func target() {
        emailTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        matchingPasswordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    func bindSignUpInformationToViewModel(_ sender: UITextField) -> Future<String, Never> {
        return Future { f in
            return f(.success(sender.text ?? ""))
        }
    }
    
}

extension ViewController {
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        if sender == emailTextField {
            bindSignUpInformationToViewModel(sender)
                .assign(to: \.email, on: viewModel)
                .store(in: &subscriptions)
            print(viewModel.email)
        } else if sender == passwordTextField {
            bindSignUpInformationToViewModel(sender)
                .assign(to: \.password, on: viewModel)
                .store(in: &subscriptions)
            print(viewModel.password)
        } else if sender == matchingPasswordTextField {
            bindSignUpInformationToViewModel(sender)
                .assign(to: \.matchingPassword, on: viewModel)
                .store(in: &subscriptions)
            print(viewModel.matchingPassword)
        }
    }
}
