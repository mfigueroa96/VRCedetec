//
//  MapViewController.swift
//  VRCedetec
//
//  Created by Martín Figueroa Padilla on 17/02/18.
//  Copyright © 2018 Martín Figueroa Padilla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000.0
        locationManager.requestWhenInUseAuthorization()
        map.mapType=MKMapType.standard
        let cl=CLLocationCoordinate2DMake(19.283996, -99.136006)
        map.region=MKCoordinateRegionMakeWithDistance(cl, 2000, 2000)
        var punto = CLLocationCoordinate2D()
        punto.latitude = 19.283996
        punto.longitude = -99.136006
        let pin = MKPointAnnotation()
        pin.coordinate = punto
        pin.title = "Tec CCM"
        pin.subtitle = "Tlalpan"
        map.addAnnotation(pin)
        map.showsCompass=true
        map.showsScale=true
        map.showsTraffic=true
        map.isZoomEnabled=true
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
            map.showsUserLocation = true
        } else {
            locationManager.stopUpdatingLocation()
            map.showsUserLocation = false
        }
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
