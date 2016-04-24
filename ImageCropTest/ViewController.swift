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

	let radius: CGFloat = UIScreen.mainScreen().bounds.width / 2 * 0.4
	
	let button = UIButton(type: UIButtonType.System)
	
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
		
		scrollView.contentSize = imageView.frame.size
		scrollView.addSubview(imageView)
		
		scrollView.maximumZoomScale = 5.0
		scrollView.minimumZoomScale = getMinimunZoomScale()
		scrollView.zoomScale = 4.5
		scrollView.clipsToBounds = false
		
		scrollView.delegate = self
		
		// move to center of the image
		scrollView.contentOffset = CGPoint(x: (imageView.bounds.size.width - scrollView.bounds.size.width) / 2, y: (imageView.bounds.size.height - scrollView.bounds.size.height) / 2)
		
//		let hole = holeLayer(radius)
//		view.layer.addSublayer(hole)
		let yoyoyoView = Hey(frame: UIScreen.mainScreen().bounds)
		yoyoyoView.reciever = scrollView
		view.addSubview(yoyoyoView)
		
		titleOnCircle("Move and scale")
		
		button.frame = CGRect(x: 0, y: 0, width: 150, height: 60)
		button.center = CGPoint(x: UIScreen.mainScreen().bounds.width * 0.9, y: UIScreen.mainScreen().bounds.height * 0.9)
		button.setTitle("幹", forState: UIControlState.Normal)
		button.addTarget(self, action: #selector(fuck), forControlEvents: UIControlEvents.TouchUpInside)
		view.addSubview(button)
	}
	
	func fuck() {
		let image = imageView.image?.CGImage
		let offset = scrollView.contentOffset
		let zoomFactor = scrollView.zoomScale
		let r = CGRect(x: offset.x/zoomFactor, y: offset.y/zoomFactor, width: radius*2/zoomFactor, height: radius*2/zoomFactor)
		let croppedImage = CGImageCreateWithImageInRect(image, r)
		
		
		let rect = CGRect(x: offset.x, y: offset.y, width: radius*2, height: radius*2)
		let _view = scrollView.resizableSnapshotViewFromRect(rect, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
		performSegueWithIdentifier("hi", sender: UIImage(CGImage: croppedImage!))
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let v = sender as? UIView {
			let vc = segue.destinationViewController as! SecondViewController
			vc.hey = v
		} else if let im = sender as? UIImage {
			let vc = segue.destinationViewController as! SecondViewController
			vc.image = im
		}
	}
	
	func titleOnCircle(text: String?) {
		let title = UILabel()
		title.frame.size.width = UIScreen.mainScreen().bounds.size.width - 40
		title.textAlignment = .Center
		title.textColor = UIColor.whiteColor()
		title.text = text
		title.font = UIFont.systemFontOfSize(30)
		title.sizeToFit()
		
		title.center.x = view.center.x
		let margin: CGFloat = 40
		title.frame.origin.y = UIScreen.mainScreen().bounds.size.height / 2 - radius - margin
		
		view.addSubview(title)
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