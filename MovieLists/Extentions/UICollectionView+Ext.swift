//
//  UICollectionView+Ext.swift
//  MovieLists
//
//  Created by Ferhat Şayık on 1.08.2025.
//

import UIKit

extension UICollectionView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
