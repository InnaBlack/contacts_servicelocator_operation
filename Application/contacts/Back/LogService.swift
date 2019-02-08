//
//  LogService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 08/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation


enum ServiceName
{
    case networkService
    case databaseService
    case syncService
    case locatorService
    case contactsService
    case rootWindowService
    case logService
}


enum EventLevel
{
    case info
    case error
    case time
}


class LogService
{
    static func log(_ service: ServiceName,level: EventLevel, message: String)
    {
        print("[\(service)] [\(level)] - \(message)")
    }
}
