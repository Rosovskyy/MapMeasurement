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
        print("THE DRAW METHOD HAS JUST BEEN COLD")
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        self.drawLine(user: context)
    }
    
    func drawLine(user context: CGContext) {
        for stroke in 0..<self.coordinates!.count - 1 {
            context.move(to: self.coordinates![stroke])
            context.addLine(to: self.coordinates![stroke + 1])
            
            context.setLineWidth(5.0)
            context.setStrokeColor(UIColor.red.cgColor)
            context.strokePath()
        }
    }

}
