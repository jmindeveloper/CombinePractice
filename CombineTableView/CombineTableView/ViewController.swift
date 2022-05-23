//
//  ViewController.swift
//  CombineTableView
//
//  Created by J_Min on 2022/05/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    private var cancelable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        viewModel.$arr
            .receive(on: DispatchQueue.main)
            // 아니 대체 왜 receive 안해주면 테이블뷰 데이터가 하나 없게보이냐,,ㅡㅡ
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &cancelable)
    }
    
    @IBAction func tapAppendButton(_ sender: UIButton) {
        viewModel.appendData(with: ["a", "b", "c", "d"].randomElement()!)
        print(viewModel.arr)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        
        cell.label.text = viewModel.arr[indexPath.row]
        
        return cell
    }
}


class Cell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}
