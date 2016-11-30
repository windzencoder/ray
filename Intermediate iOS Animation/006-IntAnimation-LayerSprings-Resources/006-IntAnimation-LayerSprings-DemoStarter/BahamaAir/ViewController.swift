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

class ViewController: UIViewController {
  
  // MARK: ui outlets
  
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!
  
  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!
  
  var didInitialLayout = false
  let info = UILabel()
  
  // MARK: view controller lifecycle
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if !didInitialLayout {
      presentationAnimations()
      didInitialLayout = true
    }
    
    username.delegate = self
    password.delegate = self
  }
  
  func presentationAnimations() {
    
    let flyRight = CASpringAnimation(keyPath: "position.x")
    
    flyRight.damping = 250
    flyRight.mass = 50.0
    flyRight.stiffness = 800
    flyRight.initialVelocity = 1.0
    
    flyRight.fromValue = -view.bounds.size.width/2
    flyRight.toValue = view.bounds.size.width/2
    flyRight.duration = flyRight.settlingDuration
    
    flyRight.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    //flyRight.speed = 1.5
    
    flyRight.fillMode = kCAFillModeBackwards
    flyRight.delegate = self
    
    flyRight.setValue("form", forKey: "name")
    flyRight.setValue(heading.layer, forKey: "layer")
    
    heading.layer.addAnimation(flyRight, forKey: nil)
    
    flyRight.beginTime = CACurrentMediaTime() + 0.33
    flyRight.setValue(username.layer, forKey: "layer")
    
    username.layer.addAnimation(flyRight, forKey: nil)
    
    flyRight.beginTime = CACurrentMediaTime() + 0.5
    flyRight.setValue(password.layer, forKey: "layer")
    password.layer.addAnimation(flyRight, forKey: nil)
    
    animateLoginButton()
    animateInfo()
    
    animateCloud(cloud1.layer)
    animateCloud(cloud2.layer)
    animateCloud(cloud3.layer)
    animateCloud(cloud4.layer)
    
  }
  
  func animateLoginButton() {
    let groupAnimation = CAAnimationGroup()
    groupAnimation.duration = 0.5
    groupAnimation.beginTime = CACurrentMediaTime() + 0.5
    groupAnimation.fillMode = kCAFillModeBackwards
    groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    
    let scaleDown = CABasicAnimation(keyPath: "transform.scale")
    scaleDown.fromValue = 3.5
    scaleDown.toValue = 1.0
    
    let rotate = CABasicAnimation(keyPath: "transform.rotation")
    rotate.fromValue = CGFloat(M_PI_4)
    rotate.toValue = 0.0
    
    let fadeIn = CABasicAnimation(keyPath: "opacity")
    fadeIn.fromValue = 0.0
    fadeIn.toValue = 1.0
    
    groupAnimation.animations = [scaleDown, rotate, fadeIn]
    loginButton.layer.addAnimation(groupAnimation, forKey: nil)
  }
  
  func animateInfo() {
    //add text info
    info.frame = CGRect(x: 0.0, y: loginButton.center.y + 30.0,
                                width: view.frame.size.width, height: 30)
    info.backgroundColor = UIColor.clearColor()
    info.font = UIFont(name: "HelveticaNeue", size: 12.0)
    info.textAlignment = .Center
    info.textColor = UIColor.whiteColor()
    info.text = "Tap on a field and enter username and password"
    view.insertSubview(info, belowSubview: loginButton)
    
    let infoGroup = CAAnimationGroup()
    infoGroup.beginTime = CACurrentMediaTime() + 0.5
    infoGroup.duration = 10.0
    infoGroup.fillMode = kCAFillModeBackwards
    infoGroup.timingFunction = CAMediaTimingFunction(
      name: kCAMediaTimingFunctionEaseOut)

    let flyLeft = CABasicAnimation(keyPath: "position.x")
    flyLeft.fromValue = info.layer.position.x + view.frame.size.width
    flyLeft.toValue = info.layer.position.x

    let fadeIn = CABasicAnimation(keyPath: "opacity")
    fadeIn.fromValue = 0.0
    fadeIn.toValue = 1.0
    fadeIn.duration = 5.0

    infoGroup.animations = [flyLeft, fadeIn]
    info.layer.addAnimation(infoGroup, forKey: "infoappear")
  }
  
  @IBAction func actionLogin(sender: AnyObject) {
    
    let startColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
    let tintColor  = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
    
    loginButton.layer.backgroundColor = tintColor.CGColor
    
    let tint = CABasicAnimation(keyPath: "backgroundColor")
    tint.fromValue = startColor.CGColor
    tint.toValue = tintColor.CGColor
    tint.duration = 1.0
    
    loginButton.layer.addAnimation(tint, forKey: nil)
    
    delay(seconds: 5, completion: {
      self.loginButton.layer.backgroundColor = startColor.CGColor
      
      tint.fromValue = tintColor.CGColor
      tint.toValue = startColor.CGColor
      self.loginButton.layer.addAnimation(tint, forKey: nil)
    })
  }
  
  func animateCloud(cloudLayer: CALayer) {
    //animate clouds
    let cloudSpeed = 30.0 / Double(view.frame.size.width)
    let duration = NSTimeInterval(view.frame.size.width -
      cloudLayer.frame.origin.x) * cloudSpeed
    
    let cloudMove = CABasicAnimation(keyPath: "position.x")
    cloudMove.duration = duration
    cloudMove.fromValue = cloudLayer.frame.origin.x
    cloudMove.toValue = view.frame.size.width + cloudLayer.frame.size.width
    cloudMove.delegate = self
    cloudMove.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

    cloudMove.setValue("cloud", forKey: "name")
    cloudMove.setValue(cloudLayer, forKey: "layer")

    cloudLayer.addAnimation(cloudMove, forKey: nil)
  }
}

extension ViewController {
  
  override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    guard let name = anim.valueForKey("name") as? String,
      let layer = anim.valueForKey("layer") as? CALayer else {
        return
    }
    
    if name == "form" {
      let bounce = CABasicAnimation(keyPath: "transform.scale")
      bounce.fromValue = 1.2
      bounce.toValue = 1.0
      bounce.duration = 0.5
      layer.addAnimation(bounce, forKey: nil)
    } else if name == "cloud" {
      layer.frame.origin.x = -layer.frame.size.width
      delay(seconds: 0.1, completion: {
        self.animateCloud(layer)
      })
    }
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(textField: UITextField) {
    print(info.layer.animationKeys())
    info.layer.removeAnimationForKey("infoappear")
  }
}
