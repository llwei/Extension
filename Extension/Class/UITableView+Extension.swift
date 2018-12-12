//
//  UITableView+Extension.swift
//  Extensions
//
//  Created by Ryan on 2018/12/4.
//  Copyright © 2018 Ryan. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// 根据cell的子视图获取当前indexPath
    func indexPath(in responder: UIResponder) -> IndexPath? {
        var indexPath: IndexPath?
        
        var next = responder.next
        while next != nil {
            if let cell = next as? UITableViewCell {
                indexPath = self.indexPath(for: cell)
                break
            } else {
                next = next?.next
            }
        }
        
        return indexPath
    }
}
