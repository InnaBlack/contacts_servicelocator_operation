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
    func loadData(from url: URL, completion: @escaping (_ data: Data?,_ errorCode: Int) -> Void)
    {
        let task = URLSession.shared.dataTask(with: url)
            { (data, response, error) in
                
                completion(data,error?._code ?? 0)
            }
        
        task.resume()
    }
}
