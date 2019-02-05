//
//  RealmContact.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift
import Realm

class RealmContact: Object
{
    @objc dynamic var identifier: String
    @objc dynamic var name: String
    @objc dynamic var height: Double
    @objc dynamic var biography: String
    @objc dynamic var temperament: String
    @objc dynamic var educationStart: String
    @objc dynamic var educationEnd: String
    
    required convenience init(identifier: String,
         name: String,
         height: Double,
         biography: String,
         temperament: String,
         educationStart: String,
         educationEnd: String)
    {
        self.identifier = identifier
        self.name = name
        self.height = height
        self.biography = biography
        self.temperament = temperament
        self.educationStart = educationStart
        self.educationEnd = educationEnd
    }
}
