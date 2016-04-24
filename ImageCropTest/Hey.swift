//
//  Hey.swift
//  ImageCropTest
//
//  Created by David on 2016/4/24.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class Hey: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
	
	let radius: CGFloat = UIScreen.mainScreen().bounds.width / 2 * 0.4
	var reciever: UIView!
		
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let hole = holeLayer(radius)
		layer.addSublayer(hole)
	}
	
	func holeLayer(circleRadius: CGFloat) -> CAShapeLayer {
		
		let borderPath = UIBezierPath(rect: UIScreen.mainScreen().bounds)
		let circlePath = UIBezierPath(ovalInRect: CGRect(x: UIScreen.mainScreen().bounds.width / 2 - circleRadius, y: UIScreen.mainScreen().bounds.height / 2 - circleRadius, width: circleRadius * 2, height: circleRadius * 2))
		borderPath.appendPath(circlePath)
		borderPath.usesEvenOddFillRule = true
		
		let holeLayer = CAShapeLayer()
		holeLayer.path = borderPath.CGPath
		holeLayer.fillRule = kCAFillRuleEvenOdd
		holeLayer.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).CGColor
		
		return holeLayer
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		if pointInside(point, withEvent: event) {
			return reciever
		}
		return nil
	}

}
