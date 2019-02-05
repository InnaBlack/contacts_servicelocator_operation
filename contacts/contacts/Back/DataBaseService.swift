//
//  DataBaseService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 30/01/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift
import Foundation

class DataBaseService
{
    lazy var contactRealm = makeContactRealm()
}

private extension DataBaseService
{
    func makeContactRealm() -> Realm
    {
        let configuration = makeContactConfiguration()
        let realm = try! Realm.init(configuration: configuration)
        
        return realm
    }
    
    func makeContactConfiguration() -> Realm.Configuration
    {
        return Realm.Configuration(
            fileURL: contactsFileUrl(),
            inMemoryIdentifier: "ContactRealm",
            readOnly: false,
            schemaVersion: 1,
            deleteRealmIfMigrationNeeded: false,
            shouldCompactOnLaunch: shouldCompact())
    }
    
    func contactsFileUrl() -> URL?
    {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return directory.appendingPathComponent("contacts.realm")
    }
    
    func shouldCompact() -> (Int,Int) -> Bool
    {
        return
            {totalBytes, usedBytes in
            
                let mbSize = 20 * 1024 * 1024
                return (totalBytes > mbSize) && (Double(usedBytes) / Double(totalBytes)) < 1/2
            }
    }
}
