//
//  SearchViewController.swift
//  SearchMovieWithCombine
//
//  Created by J_Min on 2022/05/23.
//

import UIKit
import Combine

final class SearchViewController: UIViewController {
    
    let viewModel = SearchMovieViewModel()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search Movie"
        controller.searchBar.searchBarStyle = .default
        
        return controller
    }()
    
    private var cancelable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavigationBar()
        
        searchController.searchResultsUpdater = self
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "search"
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        viewModel.fetchSearchMovie(with: query)
        
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { _ in
                resultsController.tableView.reloadData()
            }.store(in: &cancelable)
    }
}
