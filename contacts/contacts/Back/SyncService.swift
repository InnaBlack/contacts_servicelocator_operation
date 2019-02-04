//
//  SyncService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Realm


typealias simpleHandler = () -> Void


class SyncService
{
    private let serverPath = "https://github.com/SkbkonturMobile/mobile-test-ios/blob/master/json/"
    private let query = "raw=true"
    private let resourceNames = ["generated-01.json",
                                 "generated-02.json",
                                 "generated-03.json"]
    
    
    private let networkService: NetworkService
    private let databaseService: DataBaseService
    
    private let realm: RLMRealm
    
    private let syncInterval: TimeInterval = 60 // in seconds
    private var lastSyncDate = Date.distantPast
    private var syncTimer: Timer?
    
    init(networkService: NetworkService,
         databaseService: DataBaseService)
    {
        self.networkService = networkService
        self.databaseService = databaseService
        
        do
        {
            try realm = RLMRealm.init(configuration: databaseService.contactConfiguration)
        }
        catch
        {
            fatalError("Can't init Realm: \(error.localizedDescription)")
        }
        
        start()
    }
}

private extension SyncService
{
    func start()
    {
        
    }
    
    func invalidatePreviousTimerAndSendSyncAfterDelay()
    {
        syncTimer?.invalidate()
        
        syncTimer = Timer.init(timeInterval: syncInterval,
                               repeats: true,
                               block:
            { [weak self] (_) in
                
                self?.sync(with: nil)
            })
    }
    
    func sync(with completion: simpleHandler?)
    {
        var contacts = [Contact]()
        let contactsParser = ContactsParser()
        let operationsGroup = DispatchGroup()
        
        for resource in resourceNames
        {
            operationsGroup.enter()
            
            guard let requestURL = makeRequestUrl(for: resource) else {break}
            
            let requestOperation = makeRequestOperation(for: requestURL)
            
            requestOperation.completionBlock = {operationsGroup.leave()}
        }
        
        
    }
    
    func makeRequestOperation(for requestURL: URL) -> Operation
    {
        return networkService.buildOperationForLoadData(from: requestURL)
            {[weak self] (resultData, errorCode) in
                
                guard let data = resultData else {return} // Network Error
                
                guard let objectsList = self?.objectsList(from: data) else {return} // Serialization Error
                
                contacts.append(contentsOf: contactsParser.contacts(from: objectsList))
            }
    }
    
    func makeRequestUrl(for resource: String) -> URL?
    {
        let requestPath = serverPath + resource + "?" + query
        return URL.init(string: requestPath)
    }
    
    func objectsList(from data: Data) -> [Any]?
    {
        do{
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let objectsList = jsonObject as? [Any]
                else {return[]}
            
            return objectsList
        }
        catch
        {
            return nil
        }
    }
}
