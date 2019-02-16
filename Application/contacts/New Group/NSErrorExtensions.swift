//
//  NSErrorExtensions.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 14/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation

extension NSError
{
    convenience init(code: Int, message: String)
    {
        self.init(domain: Bundle.main.bundleIdentifier!,
                  code: code,
                  userInfo: [NSLocalizedDescriptionKey: message])
    }
}
