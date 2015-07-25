//
//  String+AddText.swift
//  MyLocations
//
//  Created by 赵雨 on 7/17/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import Foundation

extension String {
    mutating func addText(text: String?, withSeparator separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}