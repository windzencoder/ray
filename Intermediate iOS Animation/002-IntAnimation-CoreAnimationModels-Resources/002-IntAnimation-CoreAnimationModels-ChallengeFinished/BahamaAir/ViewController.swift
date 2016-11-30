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
  }
  
  func presentationAnimations() {
    
    let flyRight = CABasicAnimation(keyPath: "position.x")
    flyRight.fromValue = -view.bounds.size.width/2
    flyRight.toValue = view.bounds.size.width/2
    flyRight.duration = 0.5
    
    heading.layer.addAnimation(flyRight, forKey: nil)
    username.layer.addAnimation(flyRight, forKey: nil)
    password.layer.addAnimation(flyRight, forKey: nil)
    
    animateInfo()
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
    
    let flyLeft = CABasicAnimation(keyPath: "position.x")
    flyLeft.fromValue = info.layer.position.x + view.frame.size.width
    flyLeft.toValue = info.layer.position.x
    flyLeft.duration = 10.0
    info.layer.addAnimation(flyLeft, forKey: nil)
    
    let fadeIn = CABasicAnimation(keyPath: "opacity")
    fadeIn.fromValue = 0.0
    fadeIn.toValue = 1.0
    fadeIn.duration = 5.0
    info.layer.addAnimation(fadeIn, forKey: nil)
    
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
}