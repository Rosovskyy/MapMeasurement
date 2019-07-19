//
//  MapViewController.swift
//  MapMeasure
//
//  Created by Volpis on 7/19/19.
//  Copyright © 2019 Volpis. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    // MARK: - Properties
    var coordinates: [CGPoint]?
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MapView!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.layer.borderColor = UIColor.black.cgColor
        mapView.layer.borderWidth = 3
        mapView.coordinates = self.coordinates
    }
}
