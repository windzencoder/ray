import UIKit

public class RingTip : CALayer {
    
    //MARK:- Constituent Layers
    private lazy var tipLayer : CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = kCALineCapRound
        layer.lineWidth = self.ringWidth
        return layer
    }()
    
    private lazy var shadowLayer : CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = kCALineCapRound
        layer.lineWidth = self.ringWidth
        layer.strokeColor = UIColor.blackColor().CGColor
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 1.0
        layer.mask = self.shadowMaskLayer
        return layer
    }()
    
    private lazy var shadowMaskLayer : CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.blackColor().CGColor
        layer.lineCap = kCALineCapButt
        layer.lineWidth = self.ringWidth
        return layer
    }()
    
    //MARK:- Utility Properties
    private var radius : CGFloat {
        return (min(bounds.width, bounds.height) - ringWidth) / 2.0
    }
    
    private var tipPath : CGPathRef {
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: -0.01, endAngle: 0, clockwise: true).CGPath
    }
    
    private var shadowMaskPath : CGPathRef {
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true).CGPath
    }
    
    //MARK:- API Properties
    public var color: CGColorRef = UIColor.redColor().CGColor {
        didSet {
            tipLayer.strokeColor = color
        }
    }
    
    public var ringWidth: CGFloat = 40.0 {
        didSet {
            tipLayer.lineWidth = ringWidth
            shadowLayer.lineWidth = ringWidth
            shadowMaskLayer.lineWidth = ringWidth
            preparePaths()
        }
    }
    
    //MARK:- Initialisation
    public override init() {
        super.init()
        sharedInitialisation()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitialisation()
    }
    
    
    private func sharedInitialisation() {
        addSublayer(shadowLayer)
        addSublayer(tipLayer)
        color = UIColor.redColor().CGColor
        preparePaths()
    }
    
    //MARK:- Lifecycle Overrides
    override public func layoutSublayers() {
        for layer in [tipLayer, shadowLayer, shadowMaskLayer] {
            layer.bounds = bounds
            layer.position = center
        }
        preparePaths()
    }
    
    //MARK:- Utility methods
    private func preparePaths() {
        tipLayer.path = tipPath
        shadowLayer.path = tipPath
        shadowMaskLayer.path = shadowMaskPath
    }
}