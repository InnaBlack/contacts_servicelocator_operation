//
//  ContactsParser.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation


class ContactsParser
{
    lazy var dateFormatter: DateFormatter = makeDateFormatter()
    
    func contacts(from objectsList: [Any]) -> [Contact]
    {
        var contacts = [Contact]()
        
        for object in objectsList
        {
            guard let contactObject = object as? [String: Any] else {break}
            
            guard let contact = singleContact(from: contactObject) else {break}
            
            contacts.append(contact)
        }
        
        return contacts
    }
    
    func singleContact(from object: [String: Any]) -> Contact?
    {
        guard let identifier = object["id"] as? String else {return nil}
        guard let name = object["name"] as? String else {return nil}
        guard let height = object["height"] as? Double else {return nil}
        guard let biography = object["biography"] as? String else {return nil}
        guard let temperament = object["temperament"] as? String else {return nil}
        guard let educationPeriod = object["educationPeriod"] as? [String: String] else {return nil}
        guard let educationStart = educationPeriod["start"] else {return nil}
        guard let educationEnd = educationPeriod["end"] else {return nil}
        
        guard let startDate = dateFormatter.date(from: educationStart) else {return nil}
        guard let endDate = dateFormatter.date(from: educationEnd) else {return nil}
        
        let educationDates = Period.init(start: startDate, end: endDate)
        
        return Contact.init(identifier: identifier,
                            name: name,
                            height: height,
                            biography: biography,
                            temperament: Temperament.init(rawValue: temperament) ?? .choleric,
                            educationPeriod: educationDates)
    }
}

func makeDateFormatter() -> DateFormatter
{
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
}
