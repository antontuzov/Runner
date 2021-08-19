//
//  ViewController.swift
//  Runner
//
//  Created by Anton Tuzov on 17.08.2021.
//

import UIKit
import MapKit

class HomeViewController: BaseViewController {
    
    // MARK:- UIElements
    
    
    private lazy var startButton: CircularButton = {
        let Button = CircularButton()
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.borderWidth = 10
        Button.borderColor = .white
        Button.titleText = "RUN"
        Button.addTarget(self, action: #selector(startRunning), for: .touchUpInside)
        return Button
    }()
    
  
    
    private lazy var topLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Run Awesome"
        v.textAlignment = .center
        v.textColor = .darkGray
        v.font = v.font.withSize(32)
        return v
    }()
    
    private lazy var mapView: MKMapView = {
        let v = MKMapView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alpha = 0.6
        v.delegate = self
        return v
    }()
    
    // MARK:- Local variables
    private var locationManager = LocationManager()
    
    // MARK:- lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK:- Helpers
    @objc private func startRunning() {
        let currentRunVC = CurrentRunViewController()
        currentRunVC.modalPresentationStyle = .fullScreen
        present(currentRunVC, animated: true)
    }
    
    private func setupViews() {
        locationManager.checkLocationAuthorization()
        view.addSubview(topLabel)
        view.addSubview(mapView)
        view.addSubview(startButton)
    }
    
    private func setupConstraints() {
        // top label
        NSLayoutConstraint.activate([
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // map view
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // start run button
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 100),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}


// MARK:- Extension
extension HomeViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
}
