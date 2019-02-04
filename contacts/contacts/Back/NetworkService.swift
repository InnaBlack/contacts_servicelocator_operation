//
//  NetworkService.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 30/01/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation

class NetworkService
{
    func buildOperationForLoadData(from url: URL, completion: @escaping (_ data: Data?,_ errorCode: Int) -> Void) -> Operation
    {
        return LoadOperation.init
            {
                self.loadData(from: url, completion: completion)
            }
    }
    
    func loadData(from url: URL, completion: @escaping (_ data: Data?,_ errorCode: Int) -> Void)
    {
        let task = URLSession.shared.dataTask(with: url)
            { (data, response, error) in
                
                completion(data,error?._code ?? 0)
            }
        
        task.resume()
    }
}

class LoadOperation: Operation
{
    let function: () -> Void
    
    init(with function:@escaping () -> Void)
    {
        self.function = function
    }
    
    override func main()
    {
        function()
    }
}
