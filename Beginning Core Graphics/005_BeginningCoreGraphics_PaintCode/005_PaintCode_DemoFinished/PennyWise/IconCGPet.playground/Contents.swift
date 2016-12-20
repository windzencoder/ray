//: Playground - noun: a place where people can play

import UIKit


let size = CGSize(width: 400, height: 400)
let rect = CGRect(origin: .zero, size: size)

let lineWidth:CGFloat = 5.0

UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
let context = UIGraphicsGetCurrentContext()


CGContextSetLineWidth(context, lineWidth)
CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)

let insetRect = CGRectInset(rect, lineWidth/2, lineWidth/2)

CGContextFillEllipseInRect(context, insetRect)
CGContextStrokeEllipseInRect(context, insetRect)


CGContextStrokeEllipseInRect(context, CGRect(x: 130, y: 174, width: 140, height: 154))
CGContextStrokeEllipseInRect(context, CGRect(x: 71, y: 104, width: 71, height: 89))
CGContextStrokeEllipseInRect(context, CGRect(x: 161, y: 66, width: 71, height: 89))
CGContextStrokeEllipseInRect(context, CGRect(x: 254, y: 104, width: 71, height: 89))


let image = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
image

