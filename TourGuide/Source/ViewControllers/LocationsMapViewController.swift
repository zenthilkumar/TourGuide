//
//  LocationsMapViewController.swift
//  TourGuide
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import UIKit
import MapKit


enum LocationType: String {
    
    case Map   = "Map"
    case List  = "PlaceList"
}

class LocationsMapViewController: BaseViewController {

    override var pageTitle: String {
        return "Places"
    }
    
    var locations: [Location]? = []
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var gestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView.delegate = self
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        let locationContent = LocationContent.createInstanceFromFile("Locations") as? LocationContent
        locations = locationContent?.locations ?? []
        annotateLocations()
        addNavigationItem(title: LocationType.List.rawValue)
    }
    
    fileprivate func addNavigationItem(title: String) {
        
        navigationControl.addNavigationButtonItems(title: title, navigationControl: BarButtonConfiguration.Right, storyboardComponent: MapScreenStoryboard.LocationsMapViewController)
    }

    // Method that creates collections of location data to annotate in a map.
    func annotateLocations() {
        for location in locations! {
            addAnnotation(location: location)
        }
        
        // set the first coordinate as a center coordinate as users location is not serving any purpose.
        if let firstCoordinate = locations?.first {
            let coordinate = CLLocationCoordinate2D(latitude: firstCoordinate.latitude!, longitude: firstCoordinate.longitude!)
            let span = MKCoordinateSpanMake(0.15, 0.15)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            mapView.setCenter(coordinate, animated: true)
        }
    }
    
    // Add annotations in the map.
    private func addAnnotation(location: Location) {
        
        mapView.addAnnotation(location.addAnnotation())
    }
    
    // Invoked when tapping the navigation bar item.
    override func buttonItemTapped(sender: UIBarButtonItem) {
        
        if navigationControl.navigationControl?.buttonPosition == BarButtonConfiguration.Right.rawValue {
            StoryboardInstantiator().instantiateWith(data: locations, storyboard: MapScreenStoryboard.LocationsListViewController, navigationStyle: .Push)
        }
    }
    
    // Add custom annotations in the map.
    @IBAction func AddAnnotation(_ sender: Any) {
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        let addedLocation = Location.setCoordinate(coordinate: coordinate)
        locations?.append(addedLocation)
        addAnnotation(location: addedLocation)
        LocationContent.storeCustomLocations(location: addedLocation)
    }
    
    // To identify whether the tap on the mapView is over any annotation view.
    private func getTappedAnnotations(touch: UITouch) -> [MKAnnotationView] {
        
        var tappedAnnotations: [MKAnnotationView] = []
        for annotation in self.mapView.annotations {
            if let annotationView: MKAnnotationView = self.mapView.view(for: annotation) {
                let annotationPoint = touch.location(in: annotationView)
                if annotationView.bounds.contains(annotationPoint) {
                    tappedAnnotations.append(annotationView)
                }
            }
        }
        
        return tappedAnnotations
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LocationsMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            pinView?.canShowCallout = true
            pinView?.animatesDrop = true
            pinView?.pinTintColor = .purple
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        // Refreshes the callout title.
        let location = Location.returnSelectedAnnotation(annotation: view.annotation, locations: locations)
        let annotation = view.annotation as? MKPointAnnotation
        annotation?.title = location?.locationName
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let location = Location.returnSelectedAnnotation(annotation: view.annotation, locations: locations)
        StoryboardInstantiator().instantiateWith(data: location, storyboard: MapScreenStoryboard.LocationDetailViewController, navigationStyle: .Push)
    }
}

extension LocationsMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}

extension LocationsMapViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return self.getTappedAnnotations(touch: touch).isEmpty
    }
}
