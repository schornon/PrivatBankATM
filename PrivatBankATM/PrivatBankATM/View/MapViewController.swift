//
//  MapViewController.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/20/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    //weak var searchViewModel : SearchViewModel?
    
    var atm : DataATM?
    
    override func viewWillAppear(_ animated: Bool) {
        
        let location = CLLocationCoordinate2D(latitude: Double(atm!.latitude) as! CLLocationDegrees, longitude: Double(atm!.longitude) as! CLLocationDegrees)
        
        
        centerMapOnLocation(location: location)
        addAnnotationBy(location: location)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: 300, longitudinalMeters: 300)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func addAnnotationBy(location: CLLocationCoordinate2D) {
        let anno = MKPointAnnotation()
        anno.title = self.atm?.placeRu
        anno.subtitle = self.atm?.fullAddressRu
        anno.coordinate = location
        self.mapView.addAnnotation(anno)
    }

}
