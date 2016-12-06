//
//  RoundedView.swift
//  RWBooks
//
//  Created by wangzhen on 16/12/1.
//  Copyright © 2016年 Ray Wenderlich. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds,
                                       byRoundingCorners: [.TopLeft, .TopRight],
                                       cornerRadii: CGSize(width: 30.0, height: 30.0)).CGPath
        layer.mask = shapeLayer
        
        
    }

}
