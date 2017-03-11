//
//  UICollectionViewExtension.swift
//  Matrix
//
//  Created by Prateek Kohli on 11/03/17.
//  Copyright © 2017 VGgroup. All rights reserved.
//

import UIKit

extension UICollectionView
{
    func removeSpacingBetweenCells()
    {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: -0.5, right: -0.5)
        layout.itemSize = CGSize(width: self.frame.size.width/9, height: self.frame.size.width/9)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionViewLayout = layout
    }
}
