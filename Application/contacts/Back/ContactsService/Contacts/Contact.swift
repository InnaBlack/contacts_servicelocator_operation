//
//  Contact.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation

/**
 
 - Parameters:
 
 let id: String — ID контакта
 
 let name: String — Имя человека
 
 let height: Float — Рост человека
 
 let biography: String — Биография человека
 
 let temperament — Темперамент человека
    - melancholic
    - phlegmatic
    - sanguine
    - choleric
 
 let educationPeriod: Struct — Период прохождения учебы.
 - let start: Date — Начало
 - let end: Date — Окончание

 */

enum Temperament: String
{
    case undefined
    case melancholic
    case phlegmatic
    case sanguine
    case choleric
    
    init(from rawValue: String)
    {
        self = Temperament(rawValue: rawValue) ?? .undefined
    }
}

struct Period
{
    var start: Date!
    var end: Date!
    
    var duration: TimeInterval
    {
        return start.timeIntervalSince(end)
    }
    
    var stringValues: (start: String, end: String)
    {
        let dateFormatter = makeDateFormatter()
        
        return (dateFormatter.string(from: start),
                dateFormatter.string(from: end))
    }
    
    init(startDateString: String, endDateString: String)
    {
        let dateFormatter = makeDateFormatter()
        start = dateFormatter.date(from: startDateString) ?? .distantPast
        end = dateFormatter.date(from: endDateString) ?? .distantFuture
    }
    
    private func makeDateFormatter() -> DateFormatter
    {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
}

class Contact
{
    var identifier: String
    var name: String
    var height: Double
    var biography: String
    var temperament: Temperament
    var educationPeriod: Period
    
    init(identifier: String,
         name: String,
         height: Double,
         biography: String,
         temperament: Temperament,
         educationPeriod: Period)
    {
        self.identifier = identifier
        self.name = name
        self.height = height
        self.biography = biography
        self.temperament = temperament
        self.educationPeriod = educationPeriod
    }
    
    func update(from contact: Contact)
    {
        self.identifier = contact.identifier
        self.name = contact.name
        self.height = contact.height
        self.biography = contact.biography
        self.temperament = contact.temperament
        self.educationPeriod = contact.educationPeriod
    }
}
