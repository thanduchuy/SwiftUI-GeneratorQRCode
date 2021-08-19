//
//  BaseViewModel.swift
//  QRApp
//
//  Created by than.duc.huy on 19/08/2021.
//

import Foundation
import Combine

protocol BaseViewModel {
    associatedtype Output
    associatedtype Input

    func bind(_ input: Input) -> Output
}
