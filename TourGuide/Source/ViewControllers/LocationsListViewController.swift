//
//  LocationsListViewController.swift
//  TourGuide
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import UIKit

class LocationsListViewController: BaseViewController {

    override var pageTitle: String {
        return "Places"
    }
    
    var locations: [Location]?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.register(UINib(nibName: LocationViewCell.xibName, bundle: Bundle.main), forCellWithReuseIdentifier: LocationViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func passMessageWith(data: Any?) {
        
        if canControllerBeInstantiated(data: data) {
            locations = LocationContent.sortLocationByDistance(locations: data as? [Location])
        }
    }
    
    override func canControllerBeInstantiated(data: Any?) -> Bool {
        if let locationsArray = data as? [Location]? {
            return locationsArray != nil
        }
        
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LocationsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let location = locations?[indexPath.row]
        let locationViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: (location?.representingCell?.reuseIdentifier)!, for: indexPath) as? BaseCollectionCell
        locationViewCell?.configure(data: location, indexPath: indexPath)
        
        return locationViewCell!
    }
}

extension LocationsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        StoryboardInstantiator().instantiateWith(data: locations?[indexPath.row], storyboard: MapScreenStoryboard.LocationDetailViewController, navigationStyle: .Push)
    }
}

extension LocationsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let location = locations?[indexPath.row]
        return location?.representingCell?.cellHeight(data: location, containerSize: collectionView.frame.size) ?? CGSize.zero
    }
}

