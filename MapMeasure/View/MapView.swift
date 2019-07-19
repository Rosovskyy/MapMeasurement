//
//  MapView.swift
//  MapMeasure
//
//  Created by Volpis on 7/19/19.
//  Copyright © 2019 Volpis. All rights reserved.
//

import UIKit

class MapView: UIView {
    
    // MARK: - Properties
    var coordinates: [(CGFloat, CGFloat)]?

    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        self.drawLine(user: context)
    }
    
    func drawLine(user context: CGContext) {
        let horizontalCenter = self.layer.frame.width / 2
        let verticalCenter = self.layer.frame.height / 2
        let aPath = UIBezierPath()
        let originPoint = CGPoint(x: horizontalCenter + self.coordinates![0].0, y: verticalCenter + self.coordinates![0].1)
        for stroke in 1..<self.coordinates!.count - 1 {
            aPath.move(to: originPoint)
            let nextPoint = CGPoint(x: round(horizontalCenter + self.coordinates![stroke+1].0 * 50), y: round(verticalCenter + self.coordinates![stroke+1].1 * 50))
            aPath.addLine(to: nextPoint)
            aPath.lineCapStyle = .round
        }
        
        aPath.close()
        
        UIColor.red.set()
        aPath.stroke()
    }

}
