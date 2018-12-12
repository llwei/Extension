//
//  ViewController.swift
//  Extension
//
//  Created by Ryan on 2018/12/10.
//  Copyright © 2018 Ryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        btn.structMode = .leftTextRightImage(interval: 0)
//        btn.structMode = .leftImageRightText(interval: 0)
//        btn.structMode = .topTextBottomImage(interval: 0)
        btn.structMode = .topImageBottomText(interval: 0)
        
        imageView.image = imageView.image?.rotation(by: CGFloat(Double.pi / 2))
//        imageView.image = imageView.image?.horizontalFlip()
//        imageView.image = imageView.image?.verticalFlip()
     
//        let str = "abcd"
//        print(str[2])
//
//        let data = "321a4f2bb12e".hexBytes
//        print(data)
//        print(data?.hexString)
//
        
//        let dd = "0733-82343232"
        let cc = "89ju🔓😁"
        if cc.contain(with: .emoji) {
            print("isAlpha true")
        }
        
        var date = Date()
        date.day = 10
        print(date.toString("yyyy-MM-dd HH:mm"))
        print(date.weekday)
    }


}

