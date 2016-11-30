import UIKit
import XCPlayground

public class RingLayer : CALayer {
  
  private let angleOffsetForZero = CGFloat(-M_PI_2)
  
  //:- Layers
  private lazy var backgroundLayer : CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.strokeColor = self.ringBackgroundColor
    layer.lineWidth = self.ringWidth
    layer.fillColor = nil
    return layer
  }()
  
  private lazy var gradientLayer : CircularGradientLayer = {
    let layer = CircularGradientLayer()
    layer.colors = self.ringColors
    return layer
  }()
  
  private lazy var foregroundLayer : CALayer = {
    let layer = CALayer()
    layer.addSublayer(self.gradientLayer)
    layer.mask = self.foregroundMask
    layer.addSublayer(self.ringTipLayer)
    return layer
  }()
  
  private lazy var foregroundMask : CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.strokeColor = UIColor.blackColor().CGColor
    layer.fillColor = UIColor.clearColor().CGColor
    layer.lineWidth = self.ringWidth
    layer.lineCap = kCALineCapRound
    return layer
  }()
  
  private lazy var ringTipLayer : CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.strokeColor = self.ringColors.0
    layer.lineWidth = self.ringWidth
    layer.fillColor = nil
    layer.lineCap = kCALineCapRound
    return layer
  }()
  
  //:- Public API
    var value: CGFloat = 0.0 {
        didSet{
            preparePaths()
            //旋转
            gradientLayer.setValue(angleForValue(value), forKeyPath: "transform.rotation.z")
            ringTipLayer.setValue(angleForValue(value), forKeyPath: "transform.rotation.z")
        }
    }
    //ring的宽度
    var ringWidth: CGFloat = 40.0 {
        didSet{
            for layer in [backgroundLayer, foregroundMask, ringTipLayer]{
                layer.lineWidth = ringWidth
            }
        }
    }
    //ring的颜色
    var ringColors: (CGColorRef, CGColorRef) = (UIColor.redColor().CGColor, UIColor.redColor().darkerColor.CGColor) {
        
        didSet{
             gradientLayer.colors = ringColors
            ringTipLayer.strokeColor = ringColors.0
        }
        
    }
  var ringBackgroundColor: CGColorRef = UIColor.darkGrayColor().CGColor
  
  //:- Initialisation
  public override init() {
    super.init()
    sharedInitialization()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInitialization()
  }
}

extension RingLayer {
  private func sharedInitialization() {
    backgroundColor = UIColor.blackColor().CGColor
    addSublayer(backgroundLayer)
    addSublayer(foregroundLayer)
    self.value = 0.8
  }
  
  public override func layoutSublayers() {
    super.layoutSublayers()
    if backgroundLayer.bounds != bounds {
      for layer in [backgroundLayer, foregroundLayer, gradientLayer, foregroundMask, ringTipLayer] {
        layer.bounds = bounds
        layer.position = center
      }
      preparePaths()
    }
  }
}

extension RingLayer {
  private var radius : CGFloat {
    return (min(bounds.width, bounds.height) - ringWidth) / 2.0
  }
  
  private func maskPathForValue(value: CGFloat) -> CGPathRef {
    return UIBezierPath(arcCenter: center, radius: radius, startAngle: angleOffsetForZero, endAngle: angleForValue(value), clockwise: true).CGPath
  }
  
  private func angleForValue(value: CGFloat) -> CGFloat {
    return value * 2 * CGFloat(M_PI) + angleOffsetForZero
  }
  
  
  
    private var backgroundPath: CGPathRef {
        
        return maskPathForValue(1.0)
        
    }
  
  
  private func preparePaths() {
    // TODO
    backgroundLayer.path = backgroundPath
    foregroundMask.path = maskPathForValue(value)
    ringTipLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -0.01, endAngle: 0, clockwise: true).CGPath
    
  }
}




let ring = RingLayer()
ring.value = 1.6
ring.ringWidth = 20.0
ring.ringColors = (UIColor.greenColor().CGColor, UIColor.blueColor().CGColor)
viewWithLayer(ring)

