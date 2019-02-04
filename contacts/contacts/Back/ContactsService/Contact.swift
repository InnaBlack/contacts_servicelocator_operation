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
    case melancholic
    case phlegmatic
    case sanguine
    case choleric
}

struct Period
{
    let start: Date
    let end: Date
    
    var duration: TimeInterval
    {
        return start.timeIntervalSince(end)
    }
}

class Contact
{
    let identifier: String
    let name: String
    let height: Float
    let biography: String
    let temperament: Temperament
    let educationPeriod: Period
    
    init(identifier: String,
         name: String,
         height: Float,
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
}
