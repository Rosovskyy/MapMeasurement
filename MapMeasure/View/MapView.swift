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
    var scaler: CGFloat = 1
    
    override func draw(_ rect: CGRect) {
        
        if self.coordinates == nil {
            return
        }
        
        guard let context = UIGraphicsGetCurrentContext() else { return }

        self.findOptimalScaler()
        self.drawLine(user: context)
    }
    
    func drawLine(user context: CGContext) {
        let aPath = UIBezierPath()
        print(self.scaler)
        for stroke in 0..<self.coordinates!.count - 1 {
            let moveTo = stroke == 0 ? CGPoint(x: self.layer.frame.width/2, y: self.layer.frame.height/2) : CGPoint(x: round(self.coordinates![stroke].0 * self.scaler), y: round(self.coordinates![stroke].1 * self.scaler))
            aPath.move(to: moveTo)

            let nextPoint = CGPoint(x: round(self.coordinates![stroke+1].0 * self.scaler), y: round(self.coordinates![stroke+1].1 * self.scaler))
            aPath.addLine(to: nextPoint)
            aPath.lineCapStyle = .round
        }
        
        aPath.close()
        
        UIColor.red.set()
        aPath.stroke()
    }
    
    func findOptimalScaler() {
        let viewWidth = self.layer.frame.width
        let viewHeight = self.layer.frame.height
        print(self.coordinates!)
        for coord in 0..<self.coordinates!.count {
            let newX = round(viewWidth/2 + self.coordinates![coord].0 * 200)
            let newY = round(viewHeight/2 + self.coordinates![coord].1 * 200)
            let checkIfOut = self.checkIfOutOfBorder(x: newX, y: newY)
            if checkIfOut == "x" {
                self.scaler = self.scaler < viewWidth / newX ? self.scaler : viewWidth / newX
            }
            if checkIfOut == "y" {
                self.scaler = self.scaler < viewHeight / newY ? self.scaler : viewHeight / newY
            }
            self.coordinates![coord] = (newX, newY)
        }
        print(self.coordinates!)
    }
    
    func checkIfOutOfBorder(x: CGFloat, y: CGFloat) -> String? {
        let viewWidth = Int(self.layer.frame.width)
        let viewHeight = Int(self.layer.frame.height)
        if Int(x) > viewWidth || Int(x) < 0 {
            return "x"
        } else if  Int(y) > viewHeight || Int(y) < 0 {
            return "y"
        }
        return nil
    }

}
