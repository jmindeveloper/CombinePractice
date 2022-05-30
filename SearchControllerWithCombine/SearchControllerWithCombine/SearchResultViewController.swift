//
//  SearchResultViewController.swift
//  SearchControllerWithCombine
//
//  Created by J_Min on 2022/05/29.
//

import UIKit
import Combine

class SearchResultViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()
    var viewModel: ViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    static func createSearchResultViewController(viewModel: ViewModel) -> SearchResultViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
        
        vc.viewModel = viewModel
        
        return vc
    }
    
    override func viewDidLoad() {
        print("viewDidLoad")
        
        tableView.dataSource = self
        
        viewModel.filterNames()
            .sink { [unowned self] names in
                self.viewModel.searchNames = names
                self.tableView.reloadData()
            }.store(in: &subscriptions)
    }
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        cell.nameLabel.text = viewModel.searchNames[indexPath.row]
        
        return cell
    }
}

final class Cell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
}
