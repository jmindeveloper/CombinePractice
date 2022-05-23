//
//  SearchResultsViewController.swift
//  SearchMovieWithCombine
//
//  Created by J_Min on 2022/05/23.
//

import UIKit
import Combine
import SnapKit

final class SearchResultsViewController: UIViewController {
    
    private let viewModel = SearchMovieViewModel()
    private var cancelable = Set<AnyCancellable>()
    
    public let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: String(describing: SearchResultTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        view.addSubview(tableView)
        print("viewDidload")
        
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchResultTableViewCell.self), for: indexPath) as! SearchResultTableViewCell
        
        let movie = viewModel.movies[indexPath.row]
        print(movie)
        cell.configure(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
