//
//  SearchMovieViewModel.swift
//  SearchMovieWithCombine
//
//  Created by J_Min on 2022/05/23.
//

import Foundation
import Combine

class SearchMovieViewModel {
    
    private let relay = PassthroughSubject<Movie, Never>()
    private var cancelable = Set<AnyCancellable>()
    
    @Published var movies = [SearchMovieModel]() {
        willSet {
//            print(movies)
        }
    }
    
    init() {
        
    }
    
    func fetchSearchMovie(with: String) {
        APICaller.shared.fetchSearchMovieWithCombine(with: with)
            .map { $0.map { movie in SearchMovieModel(id: movie.id!,
                                                      title: movie.title!,
                                                      posterPath: movie.posterPath!,
                                                      releaseDate: movie.releaseDate!)} }
            .assign(to: \.movies, on: self)
            .store(in: &cancelable)
    }
    
}
