//
//  MapViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 17/02/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit
import WebKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "https://www.google.com/maps/place/ITESM+Mexico+City/@19.2834308,-99.1373627,17z/data=!3m1!4b1!4m5!3m4!1s0x85ce01059b077ca1:0x129534395a02e72a!8m2!3d19.2834308!4d-99.135174")
        let myRequest = URLRequest(url: myURL!)
        mapView.load(myRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ReturnToMain(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
