//
//  ViewModel.swift
//  CombineTableView
//
//  Created by J_Min on 2022/05/23.
//

import Foundation
import Combine

class ViewModel {
    @Published var arr = [String]()
    private var cancelable = Set<AnyCancellable>()
    
    public func appendData(with data: String) {
        Just(data)
            .sink { self.arr.append($0) }
            .store(in: &cancelable)
    }
}
