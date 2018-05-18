//
//  StoryboardInstantiator.swift
//  TourGuide
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import UIKit

protocol StoryboardComponent {
    
    func storyboardName() -> String
    func storyboardIdentifier() -> String
}

protocol StoryboardDataMessenger {
    
    func passMessageWith(data: Any?)
    func canControllerBeInstantiated(data: Any?) -> Bool
}

enum NavigationStyle: String {
    
    case Push = "push"
    case Present = "present"
    case Default = "default"
}

enum ModalTransitionStyle: Int {
    
    case coverVertical
    case flipHorizontal
    case crossDissolve
    case partialCurl
}

enum MapScreenStoryboard: String, StoryboardComponent {
    
    case LocationsMapViewController
    case LocationsListViewController
    case LocationDetailViewController
    
    func storyboardIdentifier() -> String {
        return self.rawValue
    }
    
    func storyboardName() -> String {
        return "MapScreen"
    }
}

class StoryboardInstantiator {
    
    func instantiateViewController(storyboard: StoryboardComponent) -> UIViewController? {
        
        let storyboardInstance = UIStoryboard.init(name: storyboard.storyboardName(), bundle: Bundle.main)
        let viewController = storyboardInstance.instantiateViewController(withIdentifier: storyboard.storyboardIdentifier())
        
        return viewController
    }
    
    func instantiateWith(data: Any?, storyboard: StoryboardComponent, navigationStyle: NavigationStyle, modalTransitionStyle: ModalTransitionStyle = .coverVertical) {
        if let baseViewController = instantiateViewController(storyboard: storyboard) as? BaseViewController {
            
            if let appDelegate  = UIApplication.shared.delegate as? AppDelegate {
                
                if let rootViewController = appDelegate.window!.rootViewController, baseViewController.canControllerBeInstantiated(data: data) {
                    baseViewController.passMessageWith(data: data)
                    switch navigationStyle {
                    case .Push:
                        if rootViewController is UINavigationController {
                            let navigationController = rootViewController as? UINavigationController
                            navigationController?.pushViewController(baseViewController, animated: true)
                        }
                    case .Present, .Default:
                        baseViewController.modalTransitionStyle = UIModalTransitionStyle.init(rawValue: modalTransitionStyle.rawValue)!
                        rootViewController.present(baseViewController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
