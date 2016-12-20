//
//  DrawIcon.swift
//  PennyWise
//
//  Created by Caroline Begbie on 29/02/2016.
//  Copyright © 2016 Caroline. All rights reserved.
//

import UIKit

class DrawIcon {
  
  class func drawFunIcon() -> UIBezierPath {
    
    let size = CGSize(width: 400, height: 400)
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    
    
    let outerCircle = UIBezierPath(ovalInRect: CGRect(x: 46, y: 46, width: 310, height: 310))
    
    let eye1 = UIBezierPath(ovalInRect: CGRect(x: 138, y: 126, width: 36, height: 72))
    
    let eye2 = UIBezierPath(ovalInRect: CGRect(x: 223, y: 126, width: 36, height: 72))
    
    let mouth = UIBezierPath()
    mouth.moveToPoint(CGPoint(x: 136, y: 250))
    mouth.addLineToPoint(CGPoint(x: 265, y: 250))
    mouth.addCurveToPoint(CGPoint(x: 135, y: 250),
      controlPoint1: CGPoint(x: 240, y: 300),
      controlPoint2: CGPoint(x: 150, y: 300))
    mouth.closePath()
    mouth.lineJoinStyle = .Round
    
    
    let path = UIBezierPath()
    path.appendPath(outerCircle)
    path.appendPath(eye1)
    path.appendPath(eye2)
    path.appendPath(mouth)
    
    UIGraphicsEndImageContext()
    return path
  }
  
  class func drawPetIcon() -> UIBezierPath {
    let size = CGSize(width: 400, height: 400)

    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    
    let paw1 = UIBezierPath(ovalInRect: CGRect(x: 130, y: 174, width: 140, height: 154))
    
    let paw2 = UIBezierPath(ovalInRect: CGRect(x: 71, y: 104, width: 71, height: 89))
    
    let paw3 = UIBezierPath(ovalInRect: CGRect(x: 161, y: 66, width: 71, height: 89))
    
    let paw4 = UIBezierPath(ovalInRect: CGRect(x: 254, y: 104, width: 71, height: 89))
    
    let path = UIBezierPath()
    path.appendPath(paw1)
    path.appendPath(paw2)
    path.appendPath(paw3)
    path.appendPath(paw4)
    
    UIGraphicsEndImageContext()
    return path

  }
}
