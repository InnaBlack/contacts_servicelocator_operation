//
//  LocatorService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 30/01/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation

class LocatorService
{
    static let current = LocatorService()
    
    var networkService: NetworkService!
    var dataBaseService: DataBaseService!
    
    lazy var syncService = makeSyncService()
    lazy var contactsService = makeContactservice()
    
    init()
    {
        initEarlyServices()
    }

    func initEarlyServices()
    {
        makeNetworkService()
        makeDataBaseService()
    }
}

private extension LocatorService
{
    func makeNetworkService()
    {
        networkService = NetworkService()
    }
    
    func makeDataBaseService()
    {
       dataBaseService = DataBaseService()
    }
    
    func makeContactservice() -> ContactsService
    {
        return ContactsService.init(databaseService: self.dataBaseService)
    }
    
    func makeSyncService() -> SyncService
    {
        return SyncService.init(networkService: self.networkService,
                                databaseService: self.dataBaseService,
                                contactsService: self.contactsService)
    }
}
