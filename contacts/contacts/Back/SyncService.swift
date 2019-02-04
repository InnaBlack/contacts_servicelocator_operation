//
//  SyncService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Realm


typealias simpleHandler = () -> Void


let syncInterval: TimeInterval = 60 // in seconds


class SyncService
{
    private let serverPath = "https://github.com/SkbkonturMobile/mobile-test-ios/blob/master/json/"
    private let query = "raw=true"
    private let resourceNames = ["generated-01.json",
                                 "generated-02.json",
                                 "generated-03.json"]
    
    
    private let networkService: NetworkService
    private let databaseService: DataBaseService
    private let contactsService: ContactsService
    private let realm: RLMRealm
    
    private var lastSyncDate = Date.distantPast
    private var syncTimer: Timer?
    
    init(networkService: NetworkService,
         databaseService: DataBaseService,
         contactsService: ContactsService)
    {
        self.networkService = networkService
        self.databaseService = databaseService
        self.contactsService = contactsService
        
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
        
        let syncQueue = OperationQueue.init()
        
        var waitResult: DispatchTimeoutResult = .timedOut
        
        let requestOperation = BlockOperation
        {[weak self] in
            
            guard let resourceNames = self?.resourceNames else {return}
            
            let contactsParser = ContactsParser()
            
            let requestsGroup = DispatchGroup()
            
            for resource in resourceNames
            {
                requestsGroup.enter()
                
                guard let requestURL = self?.makeRequestUrl(for: resource) else {break}
                
                self?.networkService.loadData(from: requestURL, completion:
                    {[weak self] (resultData, errorCode) in
                        
                        guard let data = resultData else {return} // Network Error
                        
                        guard let objectsList = self?.objectsList(from: data) else {return} // Serialization Error
                        
                        contacts.append(contentsOf: contactsParser.contacts(from: objectsList))
                        
                        requestsGroup.leave()
                    })
            }
            
            waitResult = requestsGroup.wait(timeout: .now() + syncInterval/2)
        }
        
        let responseOperation = BlockOperation
        {[weak self] in
            
            if waitResult == .success
            {
                self?.lastSyncDate = Date()
                
                self?.contactsService
            }
            
            if let syncCompletion = completion
            {
                syncCompletion()
            }
        }
        
        responseOperation.addDependency(requestOperation)
        
        syncQueue.addOperation(requestOperation)
        syncQueue.addOperation(responseOperation)
        
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
