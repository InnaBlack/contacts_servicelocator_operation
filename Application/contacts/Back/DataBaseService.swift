//
//  DataBaseService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 30/01/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift


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
        let config = Realm.Configuration(
            fileURL: contactsFileUrl(),
            schemaVersion: 1)
        return config
    }
    
    func contactsFileUrl() -> URL?
    {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return directory.appendingPathComponent("contacts.realm")
    }
}
