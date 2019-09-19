//
//  Array+Extension.swift
//  Extension
//
//  Created by Ryan on 2019/9/19.
//  Copyright © 2019 Ryan. All rights reserved.
//

import Foundation


extension Array {
    
    func at(_ index: Int) -> Element? {
        if self.count > index {
            return self[index]
        }
        return nil
    }
    
}
