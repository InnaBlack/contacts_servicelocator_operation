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
    
    lazy var syncService: SyncService = makeSyncService()
    
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
    
    func makeSyncService() -> SyncService
    {
        return SyncService.init(networkService: networkService,
                                databaseService: dataBaseService)
    }
}
