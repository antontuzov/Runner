//
//  PreviousRunDetailViewController.swift
//  Runner
//
//  Created by Anton Tuzov on 19.08.2021.
//

import UIKit
import MapKit

final class PreviousRunDetailViewController: BaseViewController {
    
    var run: Run
    
    // MARK:- UIElements
    private lazy var mapView: MKMapView = {
        let v = MKMapView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alpha = 0.6
        v.delegate = self
        return v
    }()
    
    private lazy var topHandleBackground: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return v
    }()
    
    private lazy var topHandle: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        v.layer.cornerRadius = 3
        v.layer.masksToBounds = true
        return v
    }()
    
    // MARK:- Initializers
    init(run: Run) {
        self.run = run
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setMapOverlay()
    }
    
    // MARK:- Helpers
    private func setupViews() {
        view.addSubview(mapView)
        view.addSubview(topHandleBackground)
        topHandleBackground.addSubview(topHandle)
    }
    
    private func setupConstraints() {
        // map view
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // top handle background
        NSLayoutConstraint.activate([
            topHandleBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topHandleBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topHandleBackground.topAnchor.constraint(equalTo: view.topAnchor),
            topHandleBackground.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // top handle
        NSLayoutConstraint.activate([
            topHandle.widthAnchor.constraint(equalToConstant: 100),
            topHandle.heightAnchor.constraint(equalToConstant: 6),
            topHandle.centerYAnchor.constraint(equalTo: topHandleBackground.centerYAnchor),
            topHandle.centerXAnchor.constraint(equalTo: topHandleBackground.centerXAnchor)
        ])
    }
    
    // MARK:- Helpers
    private func setMapOverlay() {
        if mapView.overlays.count > 0 {
            mapView.removeOverlays(mapView.overlays)
        }
        
        mapView.addOverlay(getPolyline(from: run))
        mapView.setRegion(centerMap(run: run), animated: true)
        
        let startPoint = MKPointAnnotation()
        startPoint.title = "Start"
        let startloc = run.locations[run.locations.count - 1]
        startPoint.coordinate = CLLocationCoordinate2D(latitude: startloc.latitude, longitude: startloc.longitude)
        mapView.addAnnotation(startPoint)
        
        let endPoint = MKPointAnnotation()
        endPoint.title = "Finish"
        let endLoc = run.locations[0]
        endPoint.coordinate = CLLocationCoordinate2D(latitude: endLoc.latitude, longitude: endLoc.longitude)
        mapView.addAnnotation(endPoint)
    }
    
    private func getPolyline(from run: Run) -> MKPolyline {
        var coord = [CLLocationCoordinate2D]()
        for location in run.locations {
            coord.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        return MKPolyline(coordinates: coord, count: run.locations.count)
    }
    
    private func centerMap(run: Run) -> MKCoordinateRegion {
        guard let (minLoc, maxLoc) = getMinMaxLocationCoord(run: run) else {
            return MKCoordinateRegion()
        }
        
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLoc.latitude + maxLoc.latitude) / 2, longitude: (minLoc.longitude + maxLoc.longitude) / 2), span: MKCoordinateSpan(latitudeDelta: (maxLoc.latitude - minLoc.latitude) * 1.5, longitudeDelta: (maxLoc.longitude - minLoc.longitude) * 1.5))
    }
    
    private func getMinMaxLocationCoord(run: Run) -> (min: CLLocationCoordinate2D, max: CLLocationCoordinate2D)? {
        let locations = run.locations
        
        guard let firstLocation = locations.first else {
            return nil
        }
        
        var minLat = firstLocation.latitude
        var minLong = firstLocation.longitude
        
        var maxLat = minLat
        var maxLong = minLong
        
        for location in locations {
            minLat = min(minLat, location.latitude)
            minLong = min(minLong, location.longitude)
            
            maxLat = max(maxLat, location.latitude)
            maxLong = max(maxLong, location.longitude)
        }
        
        return (min: CLLocationCoordinate2D(latitude: minLat, longitude: minLong), max: CLLocationCoordinate2D(latitude: maxLat, longitude: maxLong))
    }
}

// MARK:- Extensions
extension PreviousRunDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let identifier = "mapAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        if annotation.title == "Start" {
            annotationView!.pinTintColor = UIColor.red
        } else if annotation.title == "Finish" {
            annotationView!.pinTintColor = UIColor.green
        }
        
        return annotationView
    }
}
