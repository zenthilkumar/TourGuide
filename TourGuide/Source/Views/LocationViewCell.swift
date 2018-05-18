//
//  LocationViewCell.swift
//  TourGuide
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import UIKit

class LocationViewCell: BaseCollectionCell {
    
    @IBOutlet weak var placeName: UILabel!
    override func configure(data: Any?, indexPath: IndexPath?) {
        super.configure(data: data, indexPath: indexPath)
        if let location = data as? Location {
            placeName.text = location.locationName ?? "Tap to add place name"
        }
    }
    
    override class func cellHeight(data: Any?, containerSize: CGSize) -> CGSize {
        return CGSize(width: containerSize.width, height: 50.0)
    }
}
