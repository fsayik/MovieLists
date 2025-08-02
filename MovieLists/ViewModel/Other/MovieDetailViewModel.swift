//
//  MovieDetailViewModel.swift
//  MovieLists
//
//  Created by Ferhat Şayık on 2.08.2025.
//

import Foundation

protocol DetailViewModelInterface {
    var view: DetailScreenInterface? { get set }
    
    func viewDidLoad()
}


final class MovieDetailViewModel {
    weak var view: DetailScreenInterface?
}

extension MovieDetailViewModel: DetailViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configurePosterImageView()
        view?.downloadPosterImage()
        view?.configureTitleLabel()
        view?.configureDateLabel()
        view?.configureOverviewLabel()
    }
}
