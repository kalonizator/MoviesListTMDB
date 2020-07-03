//
//  Utilities.swift
//  MoviesList
//
//  Created by Адилет on 7/3/20.
//  Copyright © 2020 kalonizator corp. All rights reserved.
//

import UIKit

/// Проверка есть челка или нет
var hasTopNotch: Bool {
    if #available(iOS 11.0,  *) {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}

class Utilities: NSObject {
    
    static let shared = Utilities()
    
}
