//
//  SearchMovieModel.swift
//  SearchMovieWithCombine
//
//  Created by J_Min on 2022/05/23.
//

import Foundation

struct SearchMovieModel {
    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: String
    
    var posterUrlString: String {
        return "https://image.tmdb.org/t/p/w500/\(posterPath)"
    }
}
