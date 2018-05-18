//
//  Location.swift
//  TourGuide
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class BaseRepresentationModel {
    
    var representingCell: BaseCollectionCell.Type?
}

class Location: BaseRepresentationModel, BaseModel {
    
    fileprivate enum JsonKey: String {
        
        case Latitude                 = "lat"
        case Longitude                = "lng"
        case LocationName             = "name"
        case LocationDescription      = "LocationDescription"
    }
    
    var latitude: Double?
    var longitude: Double?
    var locationName: String?
    var locationDescription: String?
    
    var distance: Double {
        get {
            return CLLocation(latitude: latitude! , longitude: longitude!).distance(from: CLLocationManager().location!)
        }
    }
    
    class func createInstanceFrom(_ dictionary: [String: Any]?) -> Any? {
        
        guard dictionary != nil else { return nil }
        
        let instance = Location()
        instance.representingCell = LocationViewCell.self
        instance.setAttributesFromDictionary(dictionary)
        
        return instance
    }
    
    func getKeyChainData() -> [String: Any]? {
        
        var dictionary = [String: Any]()
        dictionary[JsonKey.Latitude.rawValue]               = self.latitude
        dictionary[JsonKey.Longitude.rawValue]              = self.longitude
        dictionary[JsonKey.LocationName.rawValue]           = self.locationName
        dictionary[JsonKey.LocationDescription.rawValue]    = self.locationDescription

        return dictionary
    }
    
    class func setCoordinate(coordinate: CLLocationCoordinate2D) -> Location {
        
        let location = Location()
        location.locationName = "Placeholder"
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        location.representingCell = LocationViewCell.self
        return location
    }
    
    class func returnSelectedAnnotation(annotation: MKAnnotation?, locations: [Location]?) -> Location? {
        
        if let location = locations?.filter({ $0.latitude == annotation?.coordinate.latitude && $0.longitude ==  annotation?.coordinate.longitude }).first {
            return location
        }
        
        return nil
    }
    
    func setAttributesFromDictionary(_ dictionary: [String: Any]?) {
        
        latitude = dictionary?[JsonKey.Latitude.rawValue] as? Double ?? 0
        longitude = dictionary?[JsonKey.Longitude.rawValue] as? Double ?? 0
        locationName = dictionary?[JsonKey.LocationName.rawValue] as? String
    }
}

extension Location {
    
    func addAnnotation() -> MKPointAnnotation {
        
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.title = locationName
        mapAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        return mapAnnotation
    }
}

enum JsonKey: String {
    
    case Locations     = "locations"
}
class LocationContent: BaseModel {
    
    var rawLocations: [Any]? = []
    var locations: [Location]?
    
    class func createInstanceFrom(_ dictionary: [String: Any]?) -> Any? {
        
        guard dictionary != nil else { return nil }
        
        let instance = LocationContent()
        if let locationArray = UserDefaults.standard.object(forKey: JsonKey.Locations.rawValue) {
            instance.locations = instance.listFromRawArray(locationArray as? [Any])
            return instance
        }
        instance.setAttributesFromDictionary(dictionary)
        return instance
    }
    
    func getKeyChainData() -> [String: Any]? {
        
        return nil
    }
    
    class func storeCustomLocations(location: Location?) {
        
        if location != nil && location!.getKeyChainData() != nil {
            var locations = UserDefaults.standard.object(forKey: JsonKey.Locations.rawValue) as? [Any]
            locations?.append(location!.getKeyChainData()!)
            UserDefaults.standard.set(locations, forKey: JsonKey.Locations.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    class func sortLocationByDistance(locations: [Location]?) -> [Location]? {
        if CLLocationManager().location != nil {
            return locations?.sorted { $0.distance < $1.distance }
        } else {
            
            // Return unsorted locations if current location is not yet found.
            return locations
        }
    }
    
    func setAttributesFromDictionary(_ dictionary: [String: Any]?) {
        
        let locationsArray = dictionary?[JsonKey.Locations.rawValue] as? [Any]
        rawLocations = locationsArray
        UserDefaults.standard.set(rawLocations, forKey: JsonKey.Locations.rawValue)
        UserDefaults.standard.synchronize()
        locations = listFromRawArray(locationsArray)
    }
}
