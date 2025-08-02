//
//  HomeVCViewModel.swift
//  MovieLists
//
//  Created by Ferhat Şayık on 1.08.2025.
//

import Foundation

protocol HomeViewModelInteface {
    var view: HomeScreenInteface? { get set }
    
    func viewDidLoad()
    func getMovievs()
}


final class HomeViewModel {
    weak var view: HomeScreenInteface?
    private let service = Service()
    var movies: [MovieResult] = []
    private var page: Int = 1
    var shouldDownloadMore: Bool = true
}


extension HomeViewModel: HomeViewModelInteface{
    func viewDidLoad() {
        
        view?.configureUI()
        view?.configureVC()
        getMovievs()
        
    }
    
    func getMovievs() {
        shouldDownloadMore = false
        service.downloadMovies(page: page ) { [weak self] returnedMovies in
            guard let self = self else { return }
            guard let returnedMovies = returnedMovies else { return }
            self.movies.append(contentsOf: returnedMovies)
            page += 1
            self.view?.reloadCollectionView()
            self.shouldDownloadMore = true
        }
    }
    
    func getDetail(id: Int) {
        service.downloadDetail(id: id) { [weak self] returnDetail in
            guard let self = self else { return }
            guard let returnDetail = returnDetail else { return }
            
            self.view?.navigateToDetail(movie: returnDetail)
        }
    }
    
}
