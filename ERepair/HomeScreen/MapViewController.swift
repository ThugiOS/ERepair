//
//  MapViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 30.03.23.
//

//import UIKit
//import CoreLocation
//import MapKit
//
//class MapViewController: UIViewController {
//
//    // MARK: - Variables
//    private let locationManager = CLLocationManager()
//
//    // MARK: - UI Components
//    let mapView = MKMapView()
//    private let label: UILabel = {
//        let label = UILabel()
//        label.textColor = .label
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 16, weight: .regular)
//        label.text = "Title"
//        return label
//    }()
//
//
//    // MARK: - LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//
//        mapView.showsUserLocation = true
//
//        locationManager.requestWhenInUseAuthorization()
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 53.908933, longitude: 30.333573)
//        annotation.title = "Мастерская"
//        annotation.subtitle = "Вход со двора"
//
//        mapView.addAnnotation(annotation)
//    }
//
//    // MARK: - UI Setup
//    private func setupUI() {
//        label.translatesAutoresizingMaskIntoConstraints = false
//        mapView.translatesAutoresizingMaskIntoConstraints = false
//
//
//        view.addSubview(mapView)
//        mapView.addSubview(label)
//
//        NSLayoutConstraint.activate([
//            mapView.topAnchor.constraint(equalTo: view.topAnchor),
//            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            label.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: mapView.centerYAnchor),
//        ])
//    }
//
//}
//
//extension MapViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        return nil
//    }
//}

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

    // MARK: - Variables
    private let locationManager = CLLocationManager()

    // MARK: - UI Components
    private let mapView = MKMapView()
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Title"
        label.isHidden = true
        return label
    }()
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "shop")
//        iv.tintColor = .white
        iv.isHidden = true
        iv.layer.cornerRadius = 20
        return iv
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        mapView.showsUserLocation = true

        locationManager.requestWhenInUseAuthorization()

        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 53.908933, longitude: 30.333573)
        annotation.title = "Мастерская"
        annotation.subtitle = "Вход со двора"

        mapView.addAnnotation(annotation)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTapped(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }

    // MARK: - UI Setup
    private func setupUI() {

        label.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false


        view.addSubview(mapView)
        mapView.addSubview(label)
        mapView.addSubview(imageView)


        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 330.0),
            imageView.heightAnchor.constraint(equalToConstant: 150.0),
        ])
    }

    // MARK: - Gesture Recognizer
    @objc private func mapViewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        label.isHidden = false
        imageView.isHidden = false
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}

