//
//  BaseCollectionCell.swift
//  TourGuide
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
    var indexPath: IndexPath?
    
    class var reuseIdentifier: String {
        return className
    }
    
    class var xibName: String {
        return className
    }
    
    func configure(data: Any?, indexPath: IndexPath?) {
        self.indexPath = indexPath
    }
    
    fileprivate class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    class func cellHeight(data: Any?, containerSize: CGSize) -> CGSize {
        return CGSize.zero
    }
}
