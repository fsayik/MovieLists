//
//  UIView+Ext.swift
//  MovieLists
//
//  Created by Ferhat Şayık on 1.08.2025.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
    
    func pinToEdgesOf(view: UIView) {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.topAnchor),
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    
}
