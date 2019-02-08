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
    lazy var rootWindowService = makeRootWindowService()
    
    init()
    {
        initEarlyServices()
    }

    func initEarlyServices()
    {
        initNetworkService()
        initDataBaseService()
    }
}

private extension LocatorService
{
    func initNetworkService()
    {
        networkService = NetworkService()
        LogService.log(.networkService, level: .info, message: "did create")
    }
    
    func initDataBaseService()
    {
        dataBaseService = DataBaseService()
        LogService.log(.databaseService, level: .info, message: "did create")
    }
    
    func makeContactservice() -> ContactsService
    {
        let service = ContactsService.init(databaseService: self.dataBaseService)
        LogService.log(.contactsService, level: .info, message: "did create")
        
        return service
    }
    
    func makeSyncService() -> SyncService
    {
        
        let service = SyncService.init(networkService: self.networkService,
                                databaseService: self.dataBaseService,
                                contactsService: self.contactsService)
        LogService.log(.syncService, level: .info, message: "did create")
        
        return service
    }
    
    func makeRootWindowService() -> RootWindowInput
    {
        let service =  RootWindowService()
        LogService.log(.rootWindowService, level: .info, message: "did create")
        
        return service
    }
}
