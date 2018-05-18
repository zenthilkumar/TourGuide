//
//  BaseViewController.swift
//  TourGuide
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var pageTitle: String {
        return String()
    }
    var navigationControl: NavigationBarControls = NavigationBarControls()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.title = pageTitle
    }

    @objc
    func buttonItemTapped(sender: UIBarButtonItem) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseViewController: StoryboardDataMessenger {
    
    @objc
    func passMessageWith(data: Any?) { }
    
    @objc
    func canControllerBeInstantiated(data: Any?) -> Bool {
        return false
    }
}
