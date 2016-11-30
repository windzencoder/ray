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
import QuartzCore

@IBDesignable
class AnimatedMaskLabel: UIView {
  
  let gradientLayer: CAGradientLayer = {
    let gradientLayer = CAGradientLayer()
    // Configure the gradient here
    gradientLayer.backgroundColor = UIColor.whiteColor().CGColor
    
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//    gradientLayer.locations = [0.25, 0.5, 0.75]
//    gradientLayer.colors = [
//        UIColor.blackColor(),
//        UIColor.whiteColor(),
//        UIColor.blackColor()
//        ].map{ color in color.CGColor }
    
    
    gradientLayer.locations = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
    gradientLayer.colors = [
        UIColor.yellowColor(),
        UIColor.greenColor(),
        UIColor.orangeColor(),
        UIColor.cyanColor(),
        UIColor.redColor(),
        UIColor.yellowColor()
        ].map {color in color.CGColor}
    
    
    return gradientLayer
  }()
  
  let textAttributes: [String: AnyObject] = {
    let style = NSMutableParagraphStyle()
    style.alignment = .Center
    return [
      NSFontAttributeName:UIFont(name: "HelveticaNeue-Thin", size: 28.0)!,
      NSParagraphStyleAttributeName: style
    ]
  }()
  
  func imageWithText(text: String) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
    text.drawInRect(bounds, withAttributes: textAttributes)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  
  @IBInspectable var text: String! {
    didSet {
    setNeedsDisplay()
    }
  }
  
  override func layoutSubviews() {
    
  }
  
  override func didMoveToWindow() {
    super.didMoveToWindow()
    gradientLayer.frame = bounds
    layer.addSublayer(gradientLayer)

    
    gradientLayer.frame = CGRect(
        x: -bounds.size.width,
        y: bounds.origin.y,
        width: 3 * bounds.size.width,
        height: bounds.size.height
    )
    
    let gradientAniamtion = CABasicAnimation(keyPath: "locations")
//    gradientAniamtion.fromValue = [0.0, 0.0, 0.25]
//    gradientAniamtion.toValue = [0.75, 1.0, 1.0]
    
    gradientAniamtion.fromValue = [0.0, 0.0, 0.0, 0.0, 0.0, 0.25]
    gradientAniamtion.toValue = [0.65, 0.8, 0.85, 0.9, 0.95, 1.0]
    
    gradientAniamtion.duration = 3.0
    gradientAniamtion.repeatCount = Float.infinity
    gradientLayer.addAnimation(gradientAniamtion, forKey: nil)
    
    maskView = UIImageView(image: imageWithText(text))
  }
  
}