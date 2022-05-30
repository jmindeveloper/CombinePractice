//
//  ViewModel.swift
//  SearchControllerWithCombine
//
//  Created by J_Min on 2022/05/29.
//

import Foundation
import Combine

final class ViewModel {
    
    var subscriptions = Set<AnyCancellable>()
    
    @Published var searchText: String = ""
    var searchNames = [String]()
    let allNames = ["Jimin", "Chulsu", "James", "Minji", "Ensu", "Minsu", "Harry", "Tom", "Peter", "Watson"]
    
    func filterNames() -> AnyPublisher<[String], Never> {
        $searchText
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .map { [unowned self] searchText -> [String] in
                self.allNames.filter { $0.contains(searchText) }
            }
            .eraseToAnyPublisher()
    }
}
