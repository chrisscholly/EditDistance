//
//  EditDistanceContainer.swift
//  EditDistance
//
//  Created by Kazuhiro Hayashi on 2/21/17.
//  Copyright © 2017 Kazuhiro Hayashi. All rights reserved.
//

import Foundation

public struct EditDistanceContainer<T: Comparable>: Equatable {
    public let indexPath: IndexPath
    public let element: T
    
    public init(indexPath: IndexPath, element: T) {
        self.indexPath = indexPath
        self.element = element
    }
}

public func ==<T: Comparable>(lhs: EditDistanceContainer<T>, rhs: EditDistanceContainer<T>) -> Bool {
    return lhs.element == rhs.element
}
