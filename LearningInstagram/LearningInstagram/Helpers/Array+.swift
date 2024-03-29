//
//  Array+.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 29/03/24.
//

import Foundation

extension Array {
    func repeated() -> AnyIterator<Element> {
        var index = 0
        return AnyIterator {
            defer { index = (index + 1) % self.count }
            return self[index]
        }
    }
}
