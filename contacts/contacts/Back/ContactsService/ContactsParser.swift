//
//  ContactsParser.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//


class ContactsParser
{
    func contacts(from objectsList: [Any]) -> [Contact]
    {
        var contacts = [Contact]()
        
        for object in objectsList
        {
            guard let contactObject = object as? [String: Any] else {break}
            
            contacts.append(singleContact(from: contactObject))
        }
        
        return contacts
    }
    
    func singleContact(from objects: [String: Any]) -> Contact
    {
//        let educationPeriod = Period.init(start: <#T##Date#>, end: <#T##Date#>)
        
//        return Contact.init(identifier: <#T##String#>,
//                            name: <#T##String#>,
//                            height: <#T##Float#>,
//                            biography: <#T##String#>,
//                            temperament: <#T##Temperament#>,
//                            educationPeriod: <#T##Period#>)
    }
}

//id (string) — ID контакта
//name (string) — Имя человека
//height (float) — Рост человека
//biography (string) — Биография человека
//temperament (enum) — Темперамент человека (melancholic, phlegmatic, sanguine, choleric)
//educationPeriod (object) — Период прохождения учебы. Состоит из дат start и end.
