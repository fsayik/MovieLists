//
//  Service.swift
//  MovieLists
//
//  Created by Ferhat Şayık on 31.07.2025.
//

import Foundation

final class Service {
    
    func downloadMovies(page: Int ,completion: @escaping ([MovieResult]?) -> ()) {
        
        guard let urls = URL(string: Endpoint.movies(page: page)) else { return }
        
        NetworkManager.shared.download(url: urls) { [weak self] result in
            switch result {
            case .success(let data):
                completion(self?.handleWithData(data))
            case .failure(let error):
                self?.handleWithError(error)
            }
        }
        
    }
    
    func downloadDetail(id: Int, completion: @escaping (MovieResult?) -> () ){
        
        guard let url = URL(string: Endpoint.detail(id: id)) else { return }
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
        }
        
    }
    
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    private func handleWithData (_ data: Data) -> [MovieResult]? {
        do {
            let movie = try JSONDecoder().decode(Movie.self, from: data)
            return movie.results
        }catch {
            print(error)
            return nil
        }
    }
    
    private func handleWithData (_ data: Data) -> MovieResult? {
        do {
            let movieDetail = try JSONDecoder().decode(MovieResult.self, from: data)
            return movieDetail
        }catch {
            print(error)
            return nil
        }
    }
}
