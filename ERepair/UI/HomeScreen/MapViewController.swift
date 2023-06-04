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

        self.locationManager.requestWhenInUseAuthorization()

        self.shopPin.coordinate = shopCoordinate

        self.mapView.showsUserLocation = true
        self.mapView.addAnnotation(shopPin)
        self.mapView.setRegion(MKCoordinateRegion(center: shopCoordinate,
                                             span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                    longitudeDelta: 0.01)),
                          animated: true
        )

        let tapMap = UITapGestureRecognizer(target: self, action: #selector(didTapMap(_:)))
        self.mapView.addGestureRecognizer(tapMap)
        self.showShopPhotoButton.addTarget(self, action: #selector(didTapShowPhoto), for: .touchUpInside)
        self.showLocation.addTarget(self, action: #selector(didTapShowYourLocation), for: .touchUpInside)
        self.showShopLocation.addTarget(self, action: #selector(didTapShopLocation), for: .touchUpInside)
    }

    // MARK: - UI Setup
    private func setupUI() {

        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.showShopPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        self.showLocation.translatesAutoresizingMaskIntoConstraints = false
        self.showShopLocation.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(mapView)
        self.view.addSubview(label)
        self.view.addSubview(imageView)
        self.view.addSubview(showShopPhotoButton)
        self.view.addSubview(showLocation)
        self.view.addSubview(showShopLocation)

        NSLayoutConstraint.activate([
            self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: 330.0),
            self.imageView.heightAnchor.constraint(equalToConstant: 150.0),

            self.label.bottomAnchor.constraint(equalTo: self.imageView.topAnchor, constant: -10.0),
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),

            self.showShopPhotoButton.widthAnchor.constraint(equalToConstant: 50.0),
            self.showShopPhotoButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.showShopPhotoButton.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: -30.0),
            self.showShopPhotoButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),

            self.showLocation.centerXAnchor.constraint(equalTo: self.showShopPhotoButton.centerXAnchor),
            self.showLocation.bottomAnchor.constraint(equalTo: self.showShopPhotoButton.topAnchor, constant: -10.0),
            self.showLocation.widthAnchor.constraint(equalToConstant: 50.0),
            self.showLocation.heightAnchor.constraint(equalToConstant: 50.0),

            self.showShopLocation.centerXAnchor.constraint(equalTo: self.showShopPhotoButton.centerXAnchor),
            self.showShopLocation.bottomAnchor.constraint(equalTo: self.showLocation.topAnchor, constant: -10.0),
            self.showShopLocation.widthAnchor.constraint(equalToConstant: 50.0),
            self.showShopLocation.heightAnchor.constraint(equalToConstant: 50.0),
        ])
    }

    // MARK: - Selectors
    @objc
    private func didTapMap(_ gestureRecognizer: UITapGestureRecognizer) {
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
