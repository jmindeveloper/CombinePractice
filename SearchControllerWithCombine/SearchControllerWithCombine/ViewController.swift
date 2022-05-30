//
//  ViewController.swift
//  SearchControllerWithCombine
//
//  Created by J_Min on 2022/05/29.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    private var subscriptions = Set<AnyCancellable>()
    lazy var searchController = UISearchController(searchResultsController: SearchResultViewController.createSearchResultViewController(viewModel: viewModel))
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        searchController.searchBar.searchTextField.addTarget(self, action: #selector(searchTextFieldEditingChanged(_:)), for: .editingChanged)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.searchBarStyle = .minimal
        navigationItem.searchController = searchController
        
    }
}

extension ViewController {
    @objc private func searchTextFieldEditingChanged(_ sender: UISearchTextField) {
        sender.text.publisher
            .map { $0 }
            .assign(to: \.searchText, on: viewModel)
            .store(in: &subscriptions)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        cell.nameLabel.text = viewModel.allNames[indexPath.row]
        
        return cell
    }
}
