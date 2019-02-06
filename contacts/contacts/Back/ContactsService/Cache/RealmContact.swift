//
//  RealmContact.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift
import Realm

class RealmContact: RealmSwift.Object
{
    @objc dynamic var identifier: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var height: Double = 0.0
    @objc dynamic var biography: String = ""
    @objc dynamic var temperament: String = ""
    @objc dynamic var educationStart: String = ""
    @objc dynamic var educationEnd: String = ""
    
    convenience init(identifier: String,
         name: String,
         height: Double,
         biography: String,
         temperament: String,
         educationStart: String,
         educationEnd: String)
    {
        self.init()
        
        self.identifier = identifier
        self.name = name
        self.height = height
        self.biography = biography
        self.temperament = temperament
        self.educationStart = educationStart
        self.educationEnd = educationEnd
    }
    
    convenience init(contact: Contact)
    {
        self.init()
        
        self.identifier = contact.identifier
        self.name = contact.name
        self.height = contact.height
        self.biography = contact.biography
        self.temperament = contact.temperament.rawValue
        self.educationStart = contact.educationPeriod.stringValues.start
        self.educationEnd = contact.educationPeriod.stringValues.end
    }
    
    func contact() -> Contact
    {
        return Contact.init(identifier: identifier,
                            name: name,
                            height: height,
                            biography: biography,
                            temperament: Temperament.init(from: temperament),
                            educationPeriod: Period.init(startDateString: educationStart,
                                                         endDateString: educationEnd))
    }
}
