//
//  Reused.swift
//  BusTimimg
//
//  Created by Hemant Sharma on 11/08/21.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String  { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
