//
//  LocationDetailViewController.swift
//  TourGuide
//
//  Copyright © 2018 Senthil Kumar. All rights reserved.
//

import UIKit

class LocationDetailViewController: BaseViewController {

    var location: Location?
    @IBOutlet weak var locationName: UITextField!
    @IBOutlet weak var locationDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationDescription.delegate = self
        locationName.text = location?.locationName
        locationDescription.text = location?.locationDescription ?? locationDescription.text
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        location?.locationName = locationName.text
        location?.locationDescription = locationDescription.text
    }
    
    override func passMessageWith(data: Any?) {
        
        if canControllerBeInstantiated(data: data) {
            location = data as? Location
        }
    }
    
    override func canControllerBeInstantiated(data: Any?) -> Bool {
        return data != nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LocationDetailViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Placeholder" {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
}
