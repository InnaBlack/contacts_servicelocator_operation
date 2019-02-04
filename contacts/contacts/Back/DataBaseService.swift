//
//  DataBaseService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 30/01/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Realm
import Foundation

class DataBaseService
{
    var contactConfiguration: RLMRealmConfiguration
    {
        let configuration = RLMRealmConfiguration()
        configuration.schemaVersion = 1
        configuration.objectClasses = []
        configuration.fileURL = contactsFileUrl()
        configuration.shouldCompactOnLaunch =
            {totalBytes, usedBytes in
                
            let mbSize = 20 * 1024 * 1024
            return (totalBytes > mbSize) && (Double(usedBytes) / Double(totalBytes)) < 1/2
        }
        
        return configuration
    }
}

private extension DataBaseService
{
    func contactsFileUrl() -> URL?
    {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return directory.appendingPathComponent("contacts.realm")
    }
}
