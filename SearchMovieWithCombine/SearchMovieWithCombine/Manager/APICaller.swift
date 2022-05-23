//
//  APICaller.swift
//  SearchMovieWithCombine
//
//  Created by J_Min on 2022/05/23.
//

import Foundation
import Combine

class APICaller {
    static let shared = APICaller()
    
    private init() { }
    
    public func fetchSearchMovie(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=d909d6ae76c0b5cab6a38f5921c29df4&language=en-US&query=Harry&page=1&include_adult=false") else { return }

        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            guard let result = try? JSONDecoder().decode(UnitConvert.self, from: data) else { return }
            completion(.success(result.results))
        }.resume()
    }
    
    public func fetchSearchMovieWithCombine(with query: String) -> AnyPublisher<[Movie], Never> {
        print("fetch 호출")
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=d909d6ae76c0b5cab6a38f5921c29df4&language=en-US&query=\(query)")!
        
        let session = URLSession(configuration: .default)
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: UnitConvert.self, decoder: JSONDecoder())
            .map { $0.results }
            .print()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
