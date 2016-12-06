import UIKit

class RingTip : CALayer {
    
    private lazy var tipLayer : CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = kCALineCapRound
        layer.lineWidth = self.ringWidth
        return layer
    }()
    
    //阴影layer
    private lazy var shadowLayer : CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = kCALineCapRound
        layer.strokeColor = UIColor.blackColor().CGColor
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 1.0
        layer.mask = self.shadowMaskLayer
        return layer
    }()
    
    //阴影layer的遮罩
    private lazy var shadowMaskLayer : CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.blackColor().CGColor
        layer.lineCap = kCALineCapButt
        return layer
    }()

    private var radius : CGFloat {
        return (min(bounds.width, bounds.height) - ringWidth) / 2.0
    }
    
    //tip的路径
    private var tipPath : CGPathRef {
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: -0.01, endAngle: 0, clockwise: true).CGPath
    }
    
    //阴影mask的路径
    private var shadowMaskPath : CGPathRef {
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true).CGPath
    }
    
    var color: CGColorRef = UIColor.redColor().CGColor {
        didSet {
            tipLayer.strokeColor = color
        }
    }
    
    var ringWidth: CGFloat = 40.0 {
        didSet {
            tipLayer.lineWidth = ringWidth
            shadowLayer.lineWidth = ringWidth
            shadowMaskLayer.lineWidth = ringWidth
            preparePaths()
        }
    }
    
    //MARK:- Initialisation
    override init() {
        super.init()
        sharedInitialisation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitialisation()
    }
    
    
    private func sharedInitialisation() {
        addSublayer(shadowLayer)
        addSublayer(tipLayer)
        //stroke颜色
        color = UIColor.redColor().CGColor
        preparePaths()
    }
    
    //MARK:- Lifecycle Overrides
    override func layoutSublayers() {
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
