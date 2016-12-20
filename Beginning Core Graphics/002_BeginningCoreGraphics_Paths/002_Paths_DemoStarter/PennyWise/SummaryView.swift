/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

@IBDesignable
class SummaryView: UIView {
    
    var percentSpent:Float = 0
    
    var lineWidth : CGFloat {
        return bounds.height / 4
    }
    
    let margin :  CGFloat = 30
    
    let pointerLayer = CAShapeLayer()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layer.addSublayer(pointerLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let  path = createPointerPath()
        pointerLayer.path = path.CGPath
        pointerLayer.fillColor = darkViewColor.CGColor
        pointerLayer.bounds = path.bounds
        pointerLayer.anchorPoint = CGPointMake(0.5, 1)
        pointerLayer.position = CGPointMake(bounds.midX, bounds.height - margin)
    }
    
    func createPointerPath() -> UIBezierPath {
        let pointerHeight = bounds.height - lineWidth - margin
        let pointerWidth: CGFloat = 18
        //let pointerPath = UIBezierPath(ovalInRect: CGRectMake(0, 0, pointerWidth, pointerHeight))
        
        let pointerPath = UIBezierPath()
        pointerPath.moveToPoint(CGPointMake(pointerWidth / 2, 0))
        pointerPath.addCurveToPoint(CGPointMake(pointerWidth / 2, pointerHeight),
                            controlPoint1: CGPointMake(pointerWidth / 2, 0), controlPoint2: CGPointMake(-pointerWidth, pointerHeight))
        pointerPath.addCurveToPoint(CGPointMake(pointerWidth / 2, 0),
                                    controlPoint1: CGPointMake(pointerWidth * 2, pointerHeight), controlPoint2: CGPointMake(pointerWidth / 2, 0))
        return pointerPath
    }
    
    override func drawRect(rect: CGRect) {
        let arcCenter = CGPointMake(rect.midX, rect.height - margin)
        let radius = rect.height - lineWidth / 2 - margin * 2
        let startAngle : CGFloat = π
        let endAngle : CGFloat = 0
        let  path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = lineWidth
        appGreenColor.setStroke()
        path.stroke()
        
    }
    
}






