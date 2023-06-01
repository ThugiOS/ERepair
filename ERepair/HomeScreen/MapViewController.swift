//
//  MapViewController.swift
//  ERepair
//
//  Created by Никитин Артем on 30.03.23.
//


import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

    private let locationManager = CLLocationManager()
    
    private let shopCoordinate = CLLocationCoordinate2D(latitude: 53.908933, longitude: 30.333573)
    private let shopPin: MKPointAnnotation = {
        let annotation = MKPointAnnotation()
        annotation.title = "пр-т Мира 27"
        annotation.subtitle = "Мастерская"
        return annotation
    }()

    // MARK: - UI Components
    private let mapView = MKMapView()
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "г. Могилёв, пр-т Мира 27, вход со двора\nПн-Пт 9-18"
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "shop")
        iv.isHidden = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    private let showShopPhotoButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "photo.fill"), for: .normal)
        return button
    }()
    
    private let showLocation: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "location"), for: .normal)
        return button
    }()
    
    private let showShopLocation: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "scooter"), for: .normal)
        return button
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        locationManager.requestWhenInUseAuthorization()
        
        shopPin.coordinate = shopCoordinate

        mapView.showsUserLocation = true
        mapView.addAnnotation(shopPin)
        mapView.setRegion(MKCoordinateRegion(center: shopCoordinate,
                                             span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                    longitudeDelta: 0.01)),
                          animated: true
        )

        let tapMap = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_:)))
        self.mapView.addGestureRecognizer(tapMap)
        self.showShopPhotoButton.addTarget(self, action: #selector(didTapShowPhoto), for: .touchUpInside)
        self.showLocation.addTarget(self, action: #selector(didTapShowYourLocation), for: .touchUpInside)
        self.showShopLocation.addTarget(self, action: #selector(didTapShopLocation), for: .touchUpInside)
    }

    // MARK: - UI Setup
    private func setupUI() {

        label.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        showShopPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        showLocation.translatesAutoresizingMaskIntoConstraints = false
        showShopLocation.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mapView)
        view.addSubview(label)
        view.addSubview(imageView)
        view.addSubview(showShopPhotoButton)
        view.addSubview(showLocation)
        view.addSubview(showShopLocation)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 330.0),
            imageView.heightAnchor.constraint(equalToConstant: 150.0),
            
            label.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10.0),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            showShopPhotoButton.widthAnchor.constraint(equalToConstant: 50.0),
            showShopPhotoButton.heightAnchor.constraint(equalToConstant: 50.0),
            showShopPhotoButton.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -30.0),
            showShopPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            
            showLocation.centerXAnchor.constraint(equalTo: showShopPhotoButton.centerXAnchor),
            showLocation.bottomAnchor.constraint(equalTo: showShopPhotoButton.topAnchor, constant: -10.0),
            showLocation.widthAnchor.constraint(equalToConstant: 50.0),
            showLocation.heightAnchor.constraint(equalToConstant: 50.0),
            
            showShopLocation.centerXAnchor.constraint(equalTo: showShopPhotoButton.centerXAnchor),
            showShopLocation.bottomAnchor.constraint(equalTo: showLocation.topAnchor, constant: -10.0),
            showShopLocation.widthAnchor.constraint(equalToConstant: 50.0),
            showShopLocation.heightAnchor.constraint(equalToConstant: 50.0),
        ])
    }

    // MARK: - Selectors
    @objc
    private func mapTapped(_ gestureRecognizer: UITapGestureRecognizer) {
            imageView.isHidden = true
            label.isHidden = true
    }
    
    @objc
    private func didTapShowPhoto() {
        if imageView.isHidden {
            imageView.isHidden = false
            label.isHidden = false
        } else {
            imageView.isHidden = true
            label.isHidden = true
        }
    }
    
    @objc
    private func didTapShowYourLocation() {
        let latitudeLocation = Double(locationManager.location?.coordinate.latitude ?? 0.0)
        let longitudeLocation = Double(locationManager.location?.coordinate.longitude ?? 0.0)
        
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitudeLocation,
                                                                            longitude: longitudeLocation),
                                             span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                    longitudeDelta: 0.01)),
                          animated: true
        )
    }
    
    @objc
    private func didTapShopLocation() {
        mapView.setRegion(MKCoordinateRegion(center: shopCoordinate,
                                             span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                    longitudeDelta: 0.01)),
                          animated: true
        )
    }
}

