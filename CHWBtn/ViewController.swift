//
//  ViewController.swift
//  CHWBtn
//
//  Created by Loveway on 15/7/22.
//  Copyright (c) 2015年 Henry·Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = CHWButton(count: 5, frame: CGRectMake(50, 100, 100, 50), color:nil)
        btn.animaType = CountBtnType.CHWBtnTypeScale
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        self.view.addSubview(btn)
        
        let btn2 = CHWButton(count: 5, frame: CGRectMake(200, 100, 100, 50), color:UIColor.cyanColor())
        btn2.enabled_bgColor = UIColor.greenColor()
        btn2.animaType = CountBtnType.CHWBtnTypeRotate
        btn2.layer.masksToBounds = true
        btn2.layer.cornerRadius = 5
        self.view.addSubview(btn2)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

