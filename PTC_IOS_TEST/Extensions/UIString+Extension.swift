//
//  UIString+Extension.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/18/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit
extension String{
    func strikeThrough()->NSAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
