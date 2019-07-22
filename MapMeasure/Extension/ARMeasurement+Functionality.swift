//
//  ARMeasurement+Functionality.swift
//  MapMeasure
//
//  Created by Volpis on 7/19/19.
//  Copyright © 2019 Volpis. All rights reserved.
//

import Foundation
import ARKit
import Each
import Network

extension ARMeasurementVC {
    
    // MARK: - Functionality
    func addNode() {
        guard let currentFrame = self.sceneView.session.currentFrame else { return }
        let camera = currentFrame.camera
        let transform = camera.transform

        let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.05))
        let position = transform.columns.3
        sphereNode.position = SCNVector3(position.x, 0, position.z)
        
        self.testSpeed { (speed) in
            sphereNode.geometry?.firstMaterial?.diffuse.contents = speed < 3 ? UIColor(red: speed * 255 / 3, green: 255, blue: 0, alpha: 1) : UIColor(red: 255, green: 255 - speed * 255 / 3, blue: 0, alpha: 1)
        }

        self.addCoordinate(x: CGFloat(position.x), y: CGFloat(position.z))

        self.sceneView.scene.rootNode.addChildNode(sphereNode)

        self.startingPosition = sphereNode
    }
    
    func addCoordinate(x: CGFloat, y: CGFloat) {
        if self.coordinates != nil {
            self.coordinates?.append((x, y))
        } else {
            self.coordinates = [(x, y)]
        }
    }
    
    func showAlertMessage() {
        DispatchQueue.main.async {
            let alertPresented = self.presentedViewController
            if !(alertPresented != nil && (alertPresented is UIAlertController)) {
                let alert = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        
                    case .cancel:
                        print("cancel")
                        
                    case .destructive:
                        print("destructive")
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Network
    func checkInternetConnection() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                self.setButton(button: self.startButton, text: "Start")
                self.showAlertMessage()
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func testSpeed(completion: @escaping (CGFloat) -> Void) {
        let url = URL(string: bigImage)
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let startTime = Date()
        session.dataTask(with: request) { (data, resp, error) in
            guard error == nil && data != nil else { return }
            guard resp != nil else { return }

            let length  = CGFloat( (resp?.expectedContentLength)!) / 1000000.0
            
            let downloadingTime = CGFloat( Date().timeIntervalSince(startTime))
            completion(length / downloadingTime)
        }.resume()
    }
    
    func distanceToOrigin(_ x: Float, _ y: Float, _ z: Float) -> Float {
        return (pow(x, 2) + pow(y, 2) + pow(z, 2)).squareRoot()
    }
    
    func setButton(button: UIButton, text: String) {
        DispatchQueue.main.async {
            button.setTitle(text, for: .normal)
            if button.titleLabel?.text == "Start" {
                self.canSet = true
            } else {
                self.canSet = false
            }
        }
    }
    
    // MARK: - Timer
    func setTimer() {
        self.timer.perform { () -> NextStep in
            self.countDown -= 1
            if self.countDown == 0 {
                self.sceneView.scene.rootNode.enumerateChildNodes { (childNode, _) in
//                    childNode.geometry?.firstMaterial?.diffuse.contents = UIColor.random
                }
                self.restoreTimer()
            }
            return .continue
        }
    }
    
    func restoreTimer() {
        self.countDown += 2
    }
}
