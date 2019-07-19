//
//  ARMeasurementVC.swift
//  MapMeasure
//
//  Created by Volpis on 7/19/19.
//  Copyright © 2019 Volpis. All rights reserved.
//

import UIKit
import ARKit
import Each

class ARMeasurementVC: UIViewController {
    
    // MARK: - Properties
    let configuration = ARWorldTrackingConfiguration()
    var startingPosition: SCNNode?
    var distance: Float = 0
    var timer = Each(1).seconds
    var countDown = 2
    
    // MARK: - IBOutlets
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneViewConfiguration()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - Fileprivate
    fileprivate func sceneViewConfiguration() {
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(self.configuration)
        self.sceneView.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func startTapped(_ sender: Any) {
        if self.startButton.titleLabel?.text == "Start" {
            self.addNode()
            self.setTimer()
            self.startButton.setTitle("Stop", for: .normal)
        } else {
            self.startButton.setTitle("Start", for: .normal)
        }
    }
}
