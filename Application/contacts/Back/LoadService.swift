//
//  LoadService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift


typealias simpleHandler = (_ error: Error?) -> Void


protocol LoadServiceInput
{
    func sync(with completion: simpleHandler?)
}


protocol LoadServiceOutput
{

}


class LoadService
{
    let syncInterval: TimeInterval = 60 // in seconds
    let lastLoadDateKey = "LastLoadDateKey"
    
    private let serverPath = "https://github.com/SkbkonturMobile/mobile-test-ios/blob/master/json/"
    private let query = "raw=true"
    private let resourceNames = ["generated-01.json",
                                 "generated-02.json",
                                 "generated-03.json"]
    
    
    private let networkService: NetworkService
    private let databaseService: DataBaseService
    private let contactsService: ContactsService
    
    private var lastLoadDate: Date
    {
        get
        {
            let value = UserDefaults().value(forKey: lastLoadDateKey)
            return  value as? Date ?? Date.distantPast
        }
        
        set
        {
          UserDefaults().set(newValue, forKey: lastLoadDateKey)
        }
    }
    private var syncTimer: Timer?
    
    init(networkService: NetworkService,
         databaseService: DataBaseService,
         contactsService: ContactsService)
    {
        self.networkService = networkService
        self.databaseService = databaseService
        self.contactsService = contactsService
        
        start()
    }
}


private extension LoadService
{
    func start()
    {
        let lastLoadDateTimeIntervalSinseNow = Date().timeIntervalSince(lastLoadDate)
        if lastLoadDateTimeIntervalSinseNow > syncInterval
        {
            sync(with: nil)
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


extension LoadService: LoadServiceInput
{
    func sync(with completion: simpleHandler?)
    {
        var syncErrors = [Error]()
        var date = Date()
        LogService.log(.loadService, level: .time, message: "Start \(date)")
        
        let syncQueue = OperationQueue.init()
        
        var waitResult: DispatchTimeoutResult = .timedOut
        
        let requestOperation = BlockOperation
        {
            let resourceNames = self.resourceNames
            
            let requestsGroup = DispatchGroup()
            
            LogService.log(.loadService, level: .time, message: "Start loading resources \(date.timeIntervalSinceNow) s")
            date = Date()
            
            for resource in resourceNames
            {
                requestsGroup.enter()
                
                guard let requestURL = self.makeRequestUrl(for: resource) else {break}
                
                self.networkService.loadData(from: requestURL, completion:
                    {[weak self] (resultData, error) in
                        
                        if let someData = resultData, someData.count > 0
                        {
                            self?.contactsService.writeContacts(from: someData)
                        }
                        
                        if let syncError = error
                        {
                            syncErrors.append(syncError)
                        }
                        requestsGroup.leave()
                })
            }
            
            //            requestsGroup.wait()
            waitResult = requestsGroup.wait(timeout: .now() + 30)
            
            LogService.log(.loadService, level: .time, message: "End loading resources \(date.timeIntervalSinceNow) s")
            date = Date()
        }
        
        let responseOperation = BlockOperation
        {[weak self] in
            
            DispatchQueue.main.async
                {
                    date = Date()
                    if waitResult == .success
                    {
                        self?.lastLoadDate = Date()
                    }
                    else
                    {
                        let error = NSError.init(code: 502, message: "Wait timeout")
                        
                        syncErrors.append(error)
                    }
                    
                    if let syncCompletion = completion
                    {
                        if syncErrors.isEmpty
                        {
                            syncCompletion(nil)
                        }
                        else
                        {
                            for error in syncErrors
                            {
                                syncCompletion(error)
                            }
                        }
                    }
            }
        }
        
        responseOperation.addDependency(requestOperation)
        
        syncQueue.addOperation(requestOperation)
        syncQueue.addOperation(responseOperation)
    }
}
