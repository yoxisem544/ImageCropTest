//
//  ViewController.swift
//  ImageCropTest
//
//  Created by David on 2016/4/19.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var scrollView: UIScrollView!
	var imageView: UIImageView!

	let radius: CGFloat = UIScreen.mainScreen().bounds.width / 2
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		scrollView = UIScrollView()
		scrollView.frame = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
		scrollView.center = view.center
		view.addSubview(scrollView)
		
		imageView = UIImageView(frame: UIScreen.mainScreen().bounds)
		imageView.image = UIImage(named: "a2.png")
		imageView.contentMode = .ScaleAspectFill
		imageView.sizeToFit()
		print(imageView.frame)
		scrollView.contentSize = imageView.frame.size
		scrollView.addSubview(imageView)
		
		scrollView.maximumZoomScale = 5.0
		scrollView.minimumZoomScale = getMinimunZoomScale()
		scrollView.zoomScale = 4.5
		scrollView.clipsToBounds = false
		
		scrollView.delegate = self
		print(UIScreen.mainScreen().bounds)
		// move to center of the image
		scrollView.contentOffset = CGPoint(x: (imageView.bounds.size.width - scrollView.bounds.size.width) / 2, y: (imageView.bounds.size.height - scrollView.bounds.size.height) / 2)
		
		view.layer.addSublayer(holeLayer(radius))
	}
	
	func getMinimunZoomScale() -> CGFloat {
		let imageMinSize = imageView.bounds.size.height > imageView.bounds.size.width ? imageView.bounds.size.width : imageView.bounds.size.height
		return radius * 2 / imageMinSize
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

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		scrollView.zoomScale = 0.5
	}

}

extension ViewController : UIScrollViewDelegate {
	func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}