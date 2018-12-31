//
//  CSStepper.swift
//  Travely_iOS
//
//  Created by seunghwan Lee on 30/12/2018.
//  Copyright © 2018 신동규. All rights reserved.
//

import UIKit

@IBDesignable
public class CSStepper: UIControl {
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public var leftBtn = UIButton(type: .system)
    public var rightBtn = UIButton(type: .system)
    public var centerLabel = UILabel()
    
    @IBInspectable
    public var stepValue: Int = 1
    
    @IBInspectable
    public var maximumValue: Int = 100
    
    @IBInspectable
    public var minimumValue: Int = 0
    
    
    @IBInspectable
    public var value: Int = 0 {
        didSet {
            self.centerLabel.text = String(value)
            
            self.sendActions(for: .valueChanged)
        }
    }
    
    @IBInspectable
    public var leftTitle: String = "-" {
        didSet {
            self.leftBtn.setTitle(leftTitle, for: .normal)
        }
    }
    
    @IBInspectable
    public var rightTitle: String = "+" {
        didSet {
            self.rightBtn.setTitle(rightTitle, for: .normal)
        }
    }
    
    @IBInspectable
    public var bgColor: UIColor = UIColor.white {
        didSet{
            self.centerLabel.backgroundColor = backgroundColor
        }
    }
    
    private func setup() {
        
        //        let borderWidth: CGFloat = 0.5
        //        let borderColor = UIColor.gray.cgColor
        
        self.leftBtn.tag = -1
        //        self.leftBtn.setTitle("-", for: .normal)
        self.leftBtn.setTitle(self.leftTitle, for: .normal)
        self.leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //        self.leftBtn.layer.borderWidth = borderWidth
        //        self.leftBtn.layer.borderColor = borderColor
        self.leftBtn.setTitleColor(.gray, for: .normal)
        
        self.rightBtn.tag = 1
        //        self.rightBtn.setTitle("+", for: .normal)
        self.rightBtn.setTitle(self.rightTitle, for: .normal)
        self.rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        //        self.rightBtn.layer.borderWidth = borderWidth
        //        self.rightBtn.layer.borderColor = borderColor
        self.rightBtn.setTitleColor(.gray, for: .normal)
        
        
        self.centerLabel.text = String(value)
        self.centerLabel.font = UIFont.systemFont(ofSize: 16)
        self.centerLabel.textAlignment = .center
        //        self.centerLabel.backgroundColor = UIColor.white
        self.centerLabel.backgroundColor = self.bgColor
        //        self.centerLabel.layer.borderWidth = borderWidth
        //        self.centerLabel.layer.borderColor = borderColor
        
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        self.addSubview(self.centerLabel)
        
        self.leftBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        self.rightBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        
    }
    
    @objc public func valueChange(_ sender: UIButton) {
        let sum = self.value + (sender.tag * self.stepValue)
        
        if sum > self.maximumValue {
            return
        }
        
        if sum < self.minimumValue {
            return
        }
        self.value += (sender.tag * self.stepValue)
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let borderWidth: CGFloat = 0.5
        let borderColor = UIColor.gray
        
        let btnWidth = self.frame.height
        
        let lblWidth = self.frame.width - (btnWidth * 2)
        
        self.leftBtn.frame = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
        self.centerLabel.frame = CGRect(x: btnWidth, y: 0, width: lblWidth, height: btnWidth)
        self.rightBtn.frame = CGRect(x: btnWidth+lblWidth, y: 0, width: btnWidth, height: btnWidth)
        
        self.leftBtn.layer.addBorder1([.top, .bottom, .left, .right], color: borderColor, width: borderWidth)
        self.rightBtn.layer.addBorder2([.top, .bottom, .left, .right], color: borderColor, width: borderWidth)
        self.centerLabel.layer.addBorder1([.top, .bottom], color: borderColor, width: borderWidth)
    }
    
}

