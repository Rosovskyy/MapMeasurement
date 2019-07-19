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

extension ARMeasurementVC {
    
    // MARK: - Functionality
    func addNode() {
        guard let currentFrame = self.sceneView.session.currentFrame else { return }
        let camera = currentFrame.camera
        let transform = camera.transform
        
        let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.05))
        sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        sphereNode.simdTransform = transform
        
        self.sceneView.scene.rootNode.addChildNode(sphereNode)
        
        if self.startingPosition != nil {
            self.startingPosition?.append(sphereNode)
        } else {
            self.startingPosition = [sphereNode]
        }
    }
    
    func setTimer() {
        self.timer.perform { () -> NextStep in
            self.countDown -= 1
            if self.countDown == 0 {
                self.sceneView.scene.rootNode.enumerateChildNodes { (childNode, _) in
                    childNode.geometry?.firstMaterial?.diffuse.contents = UIColor.random
                }
                self.restoreTimer()
            }
            return .continue
        }
    }
    
    func restoreTimer() {
        self.countDown += 2
    }
    
    func distanceToOrigin(_ x: Float, _ y: Float, _ z: Float) -> Float {
        return (pow(x, 2) + pow(y, 2) + pow(z, 2)).squareRoot()
    }
}

