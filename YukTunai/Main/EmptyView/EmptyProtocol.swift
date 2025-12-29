//
//  EmptyProtocol.swift
//  Toni
//
//  Created by 张文 on 2022/5/19.
//

import UIKit

struct Empty<T> {
    public let Empty: T
    public init(_ dataSource: T) {
        Empty = dataSource
    }
}


extension NSObjectProtocol {
    var empty: Empty<Self> {
        return Empty(self)
    }
}


