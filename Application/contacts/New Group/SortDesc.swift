//
//  SortDesc.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation


typealias SortDescriptor<Value> = (Value, Value) -> Bool


class SortDesc {
    typealias SortDescriptor<Value> = (Value, Value) -> Bool
    
    static func sortDescriptor<Value, Key>(
        key: @escaping (Value) -> Key,
        ascending: Bool = true,
        _ comparator: @escaping (Key) -> (Key) -> ComparisonResult
        ) -> SortDescriptor<Value> {
        return { lhs, rhs in
            let order: ComparisonResult = ascending ? .orderedAscending : .orderedDescending
            return comparator(key(lhs))(key(rhs)) == order
        }
    }
    
    static func combine<Value>
        (sortDescriptors: [SortDescriptor<Value>]) -> SortDescriptor<Value> {
        return { lhs, rhs in
            for isOrderedBefore in sortDescriptors {
                if isOrderedBefore(lhs,rhs) { return true }
                if isOrderedBefore(rhs,lhs) { return false }
            }
            return false
        }
    }
    
    static func lift<A>(_ compare: @escaping (A) -> (A) -> ComparisonResult) -> (A?) -> (A?) -> ComparisonResult {
        return {
            lhs in
            { rhs in
                switch (lhs, rhs) {
                case (nil, nil): return .orderedSame
                case (nil, _): return .orderedAscending
                case (_, nil): return .orderedDescending
                case let (l?, r?): return compare(l)(r)
                default: fatalError() // Impossible case
                }
            }
        }
    }
    
    static func simpleAccending<A : Comparable>() -> (A?) -> (A?) -> ComparisonResult {
        return SortDesc.lift {(first: A) -> (A) -> ComparisonResult in {(second: A) -> ComparisonResult in first < second ? .orderedAscending : .orderedDescending}}
    }
}
