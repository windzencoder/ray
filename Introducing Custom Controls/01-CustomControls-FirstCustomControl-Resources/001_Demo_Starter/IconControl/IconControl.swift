//
//  IconControl.swift
//  IconControl
//
//  Created by wangzhen on 16/11/30.
//  Copyright © 2016年 Razeware. All rights reserved.
//

import UIKit

class IconControl: UIView {

    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFontOfSize(30.0, weight: UIFontWeightLight)
        return label
    }()
    
    private  var spacingConstraint: NSLayoutConstraint!
    
    var spacing: CGFloat = 20.0 {
        didSet{
            spacingConstraint!.constant = spacing
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInitalizaiton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitalizaiton()
    }
    
}

extension IconControl {
    var image: UIImage? {
        get {
            return imageView.image
        }
        set(newImage) {
            imageView.image = newImage?.imageWithRenderingMode(.AlwaysTemplate)
        }
    }
    
    var text: String? {
        get {
            return label.text
        }
        set(newText) {
            label.text = newText
        }
    }
    
    
}

extension IconControl {
    private func sharedInitalizaiton() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(imageView)
        
        //创建约束 间隔
        spacingConstraint = label.leftAnchor.constraintEqualToAnchor(imageView.rightAnchor, constant: spacing)
        
        NSLayoutConstraint.activateConstraints([
            imageView.leadingAnchor.constraintEqualToAnchor(layoutMarginsGuide.leadingAnchor),
            imageView.topAnchor.constraintEqualToAnchor(layoutMarginsGuide.topAnchor),
            imageView.bottomAnchor.constraintEqualToAnchor(layoutMarginsGuide.bottomAnchor),
            spacingConstraint,
            label.rightAnchor.constraintEqualToAnchor(layoutMarginsGuide.rightAnchor),
            imageView.centerYAnchor.constraintEqualToAnchor(label.centerYAnchor)
            
            ])
        
        //设置如何压缩和拉伸
        label.setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Horizontal)
        imageView.setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Horizontal)
        setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Horizontal)
        
        layer.cornerRadius = 10
        
        
    }
}







