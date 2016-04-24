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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		view.addSubview(hey)
		
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
