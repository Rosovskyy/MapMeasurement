//
//  ARMeasurement+ARSCNViewDelegate.swift
//  MapMeasure
//
//  Created by Volpis on 7/19/19.
//  Copyright © 2019 Volpis. All rights reserved.
//

import Foundation
import ARKit
import Network

extension ARMeasurementVC: ARSCNViewDelegate {
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if !self.canSet {
            return
        }
        self.checkInternetConnection()
        guard let startingPosition = self.startingPosition else { return }
        guard let pointOfView = self.sceneView.pointOfView else { return }
        
        let transform = pointOfView.transform
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let xDistance = location.x - startingPosition.position.x
        let yDistance = location.y - startingPosition.position.y
        let zDistance = location.z - startingPosition.position.z
        self.distance = self.distanceToOrigin(xDistance, yDistance, zDistance)
        if self.distance > 0.5 {
            self.addNode()
            self.distance = 0
        }
    }
}
