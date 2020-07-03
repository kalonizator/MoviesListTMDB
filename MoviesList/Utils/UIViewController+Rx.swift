//
//  UIViewController+Rx.swift
//  MoviesList
//
//  Created by Адилет on 25/01/2019.
//  Copyright © 2019 kalonizator. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
}
