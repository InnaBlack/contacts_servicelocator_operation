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
    var readRealm: Realm!
    var newRealm: Realm
    {
        let configuration = self.makeContactConfiguration(readOnly: false)
        return try! Realm.init(configuration: configuration)
    }
    
    init()
    {
        let configuration = self.makeContactConfiguration(readOnly: false)
        self.readRealm = try! Realm.init(configuration: configuration)
    }
}

private extension DataBaseService
{
    func makeContactConfiguration(readOnly: Bool) -> Realm.Configuration
    {
        return Realm.Configuration(
            fileURL: contactsFileUrl(),
            inMemoryIdentifier: "ContactRealm",
            readOnly: readOnly,
            schemaVersion: 1,
            deleteRealmIfMigrationNeeded: false)
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

extension Realm {
    func writeAsync<T : ThreadConfined>(obj: T, errorHandler: @escaping ((_ error : Swift.Error) -> Void) = { _ in return }, block: @escaping ((Realm, T?) -> Void)) {
        let wrappedObj = ThreadSafeReference(to: obj)
        let config = self.configuration
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: config)
                    let obj = realm.resolve(wrappedObj)
                    
                    try realm.write {
                        block(realm, obj)
                    }
                }
                catch {
                    errorHandler(error)
                }
            }
        }
    }
}
