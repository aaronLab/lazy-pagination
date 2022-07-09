//
//  Array+Ext.swift
//  LazyPagination
//
//  Created by Aaron Lee on 2022/07/09.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
