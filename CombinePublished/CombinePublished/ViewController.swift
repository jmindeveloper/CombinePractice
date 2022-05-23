//
//  ViewController.swift
//  CombinePublished
//
//  Created by J_Min on 2022/05/23.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var someView: UIView!
    
    @Published private var isHidden = false
    @Published private var someViewColor: UIColor? = .systemRed
    // view의 백그라운드컬러는 옵셔널타입이기때문에 퍼블리셔 타입도 옵셔널이여야 한다
    private var colors: [UIColor] = [.systemRed, .systemBlue, .systemCyan, .systemIndigo, .systemOrange]
    
    private var cancelable = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeViewPropertiesWithCombine()
    }
    
    private func changeViewPropertiesWithCombine() {
        $isHidden.assign(to: \.isHidden, on: someView).store(in: &cancelable)
//        $someViewColor.sink { [weak self] in self?.someView.backgroundColor = $0 }.store(in: &cancelable)
        $someViewColor
            .assign(to: \.backgroundColor, on: someView)
            .store(in: &cancelable)
    }

    @IBAction func tapHideViewButton(_ sender: Any) {
        isHidden.toggle()
    }
    
    @IBAction func tapChangeSomeViewColor(_ sender: Any) {
        someViewColor = colors.randomElement() ?? .systemRed
    }
}

