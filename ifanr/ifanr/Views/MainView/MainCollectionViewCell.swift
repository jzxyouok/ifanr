//
//  MainCollectionViewCell.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/11.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

class MainCollectionViewCell: UICollectionViewCell, Reusable {
    
    var childVCView: UIView! {
        didSet {
            self.contentView.addSubview(childVCView)
        }
    }
}