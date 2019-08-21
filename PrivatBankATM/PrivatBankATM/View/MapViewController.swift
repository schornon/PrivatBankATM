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
        
        addTimeWorkView(to: view)
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
    
    private func addTimeWorkView(to view: UIView) {
        
        let twView = UIView()
        twView.backgroundColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0)
        twView.alpha = 0.9
        twView.layer.cornerRadius = 5
        twView.layer.borderColor = UIColor.darkGray.cgColor
        twView.layer.borderWidth = 2.0
        twView.layer.masksToBounds = true
        twView.layer.borderColor = UIColor(red:0.71, green:0.71, blue:0.71, alpha:1.0).cgColor
        view.addSubview(twView)
        
        twView.translatesAutoresizingMaskIntoConstraints = false
        twView.topAnchor.constraint(equalTo: view.topAnchor, constant: 105).isActive = true
        twView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        twView.widthAnchor.constraint(equalToConstant: 184).isActive = true
        twView.heightAnchor.constraint(equalToConstant: 185).isActive = true
        
        let twArray = ["Mon:\t\(self.atm!.tw.mon)", "Tue:\t\(self.atm!.tw.tue)", "Wed:\t\(self.atm!.tw.wed)", "Thu:\t\(self.atm!.tw.thu)", "Fri:\t\t\(self.atm!.tw.fri)", "Sat:\t\(self.atm!.tw.sat)", "Sun:\t\(self.atm!.tw.sun)", "Hol:\t\(self.atm!.tw.hol)"]

        var top : CGFloat = 3.0
        for t in twArray {
            let label = UILabel()
            twView.addSubview(label)
            label.text = t
            
            let margins = twView.layoutMarginsGuide
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 2).isActive = true
            label.topAnchor.constraint(equalTo: margins.topAnchor, constant: top).isActive = true
            top += 20.0
        }
    }

}
