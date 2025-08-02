//
//  ViewController.swift
//  MovieLists
//
//  Created by Ferhat Şayık on 31.07.2025.
//

import UIKit


protocol HomeScreenInteface: AnyObject {
    func configureVC()
    func configureUI()
    func reloadCollectionView()
    func navigateToDetail(movie: MovieResult)
}


class HomeVC: UIViewController {

    private let viewModel = HomeViewModel()
  
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        
        
    }

}

extension HomeVC: HomeScreenInteface {
    
    func configureVC() {
        title = "Moviesss"
        view.backgroundColor = .systemBlue
    }
    
    func configureUI() {
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubViews(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
        
        collectionView.pinToEdgesOf(view: view)
    }
    
    func reloadCollectionView() {
           collectionView.reloadOnMainThread()
       }
    
    func navigateToDetail(movie: MovieResult) {
        DispatchQueue.main.async {
            let vc = MovieDetailVC(movie: movie)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        cell.setCell(movie: viewModel.movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(id: viewModel.movies[indexPath.item]._id)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        guard contentHeight != 0 else { return }
        
        if offsetY >= contentHeight - (2 * height) && viewModel.shouldDownloadMore {
            viewModel.getMovievs()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       /* let offsetY = scrollView.contentOffset.y
        let contentHight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHight - (5 * height){
            print("add movies")
            viewModel.getMovievs()
        }*/
    }
    
}
