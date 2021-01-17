//
//  MapViewController.swift
//  Artly
//
//  Created by Aleksander Wędrychowski on 17/01/2021.
//

import Foundation
import MapKit

final class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    private var mapView: MKMapView!
    private let region: MKCoordinateRegion
    
    // MARK: - Lifecycle
    
    init(_ region: MKCoordinateRegion) {
        self.region = region
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegion()
        setupNavigationBar()
    }
    
    // MARK: - Private
    
    private func setRegion() {
        mapView.setRegion(region, animated: false)
    }
    
    private func setupNavigationBar() {
        let closeItem = UIBarButtonItem(title: Strings.close.localized, style: .done, target: self, action: #selector(closeTapped))
        navigationItem.leftBarButtonItem = closeItem
    }
    
    // MARK: - Actions
    
    @objc private func closeTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
