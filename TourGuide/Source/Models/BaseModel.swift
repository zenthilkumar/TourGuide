//
//  BaseModel.swift
//  TourGuide
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import Foundation

protocol BaseModel {
    
    static func createInstanceFrom(_ dictionary: [String: Any]?) -> Any?
    static func createInstanceFromData(_ data: Data) -> Any?
    static func createInstanceFromFile(_ fileName: String) -> Any?
    
    func getKeyChainData() -> [String: Any]?
    func setAttributesFromDictionary(_ dictionary: [String: Any]?)
}

extension BaseModel {
    
    static func createInstanceFromData(_ data: Data) -> Any? {
        
        if let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            return createInstanceFrom(jsonDictionary)
        }
        
        return nil
    }
    
    static func createInstanceFromFile(_ fileName: String) -> Any? {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return createInstanceFromData(data)
            }
        }
        
        return nil
    }
    
    func listFromRawArray<B: BaseModel>(_ listArray:[Any]?) -> [B]? {
        if listArray == nil {
            return nil
        }
        
        var itemList = [B]()
        for (element) in listArray! {
            let instance = B.createInstanceFrom(element as? [String : Any]) as? B
            
            if instance != nil {
                itemList.append(instance!)
            }
        }
        
        return itemList
    }
}
