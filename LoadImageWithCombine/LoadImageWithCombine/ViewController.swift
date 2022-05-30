//
//  ViewController.swift
//  LoadImageWithCombine
//
//  Created by J_Min on 2022/05/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let urlString = "https://picsum.photos/1024"
    private var cancelable = Set<AnyCancellable>()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tapRefrashButton(_ sender: Any) {
        
        loadImageWithCombine(urlString)
            .receive(on: DispatchQueue.main)
            // assign 은 에러가 Never일때만 사용가능하다
            .assign(to: \.image, on: imageView)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    print(error.localizedDescription)
//                default:
//                    break
//                }
//            }, receiveValue: { [weak self] image in
//                self?.imageView.image = image
//            })
            .store(in: &cancelable)
    }
    
    private func loadImageWithCombine(_ url: String) -> AnyPublisher<UIImage?, Never> {
        let url = URL(string: url)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
//            .mapError { $0 as Error }
            // replaceError --> error가 발생했을때 default 값, error를 없앤다
            .replaceError(with: UIImage(systemName: "person")!)
            .eraseToAnyPublisher()
    }
}

