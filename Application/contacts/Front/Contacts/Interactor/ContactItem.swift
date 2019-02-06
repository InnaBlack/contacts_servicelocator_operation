//
//  ContactItem.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

class ContactItem
{
    let identifier: String
    let title: String
    let subtitle: String
    let detail: String
    
    init(identifier: String,
         title: String,
         subtitle: String,
         detail: String)
    {
        self.identifier = identifier
        self.title = title
        self.subtitle = subtitle
        self.detail = detail
    }
}
