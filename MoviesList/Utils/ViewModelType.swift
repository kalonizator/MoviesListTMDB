//
//  ViewModelType.swift
//  MoviesList
//
//  Created by Адилет on 25/01/2019.
//  Copyright © 2019 kalonizator. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
