//
//  MapViewController.swift
//  LosAltosHacks
//
//  Created by Justin Yu on 1/4/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {

    @IBOutlet weak var mapView: MKMapView!

    let regionRadius: CLLocationDistance = 100

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
        regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self

        let LAH = CLLocation(latitude: 37.413639, longitude: -122.071918)
        centerMapOnLocation(LAH)

        let annotation = MKPointAnnotation()
        annotation.coordinate = LAH.coordinate
        annotation.title = "Microsoft SV Campus"
        annotation.subtitle = "1065 La Avenida Street, Mountain View, CA 94043"

        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
    }

    override func setupConstraints() {

        mapView.snp_makeConstraints { make in
            make.topMargin.equalTo(snp_topLayoutGuideBottom)
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.bottomMargin.equalTo(snp_bottomLayoutGuideTop)
        }
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        if let annotation = view.annotation {
            let placemark = MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)
            let item = MKMapItem(placemark: placemark)
            item.name = "Los Altos Hacks"
            item.openInMapsWithLaunchOptions(nil)
        }

    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "MapPin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }

        let button = UIButton(type: UIButtonType.DetailDisclosure) as UIButton // button with info sign in it
        pinView?.rightCalloutAccessoryView = button

        return pinView
    }
}
