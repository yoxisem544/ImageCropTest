//
//  SecondViewController.swift
//  ImageCropTest
//
//  Created by David on 2016/4/24.
//  Copyright © 2016年 David. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
	
	var hey: UIView!
	var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let imv = UIImageView()
		imv.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
		view.addSubview(imv)
		imv.image = image
		imv.backgroundColor = UIColor.lightGrayColor()
		
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shit)))
    }
	
	func shit() {
		dismissViewControllerAnimated(true, completion: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
