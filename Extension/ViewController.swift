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
//        btn.structMode = .topImageBottomText(interval: 0)
        
//        imageView.image = imageView.image?.rotation(by: CGFloat(Double.pi / 2))
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
//        let cc = "89ju🔓😁"
//        if cc.contain(with: .emoji) {
//            print("isAlpha true")
//        }
//
//        var date = Date()
//        date.day = 10
//        print(date.toString("yyyy-MM-dd HH:mm"))
//        print(date.weekday)
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let alert = UIAlertController(title: "退保证金后，将再也无法获得收益",
                                      message: "从 3 月 26 日起，所有未交保证金的店主，不再享受店主权益（包括但不限于下级店主返佣、店主店铺销售差额收益、任务奖励）",
                                      preferredStyle: .alert)
        let cancel = UIAlertAction(title: "不退了", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "退保证金", style: .default, handler: nil)
        alert.addAction(confirm)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 3
        alert.titleAttributes = [NSAttributedString.Key.foregroundColor : UIColor.red,
                                 NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        alert.messageAttributes = [NSAttributedString.Key.foregroundColor : UIColor.lightGray,
                                   NSAttributedString.Key.paragraphStyle : paragraphStyle]
        cancel.titleColor = UIColor.red
        confirm.titleColor = UIColor.lightGray
        
    }
    
}

