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
    var coordinates: [CGPoint]?

    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        self.drawLine(user: context)
    }
    
    func drawLine(user context: CGContext) {
        let aPath = UIBezierPath()
        aPath.move(to: self.coordinates![0])
        for stroke in 1..<self.coordinates!.count - 1 {
            aPath.addLine(to: self.coordinates![stroke + 1])
            aPath.lineCapStyle = .round
        }
        
        aPath.close()

        UIColor.red.set()
        aPath.stroke()
    }

}
