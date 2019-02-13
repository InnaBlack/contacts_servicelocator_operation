//
//  Contact.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift
import Realm

class Contact: RealmSwift.Object, Codable
{
    @objc dynamic var identifier: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var height: Double = 0.0
    @objc dynamic var biography: String = ""
    @objc dynamic var temperament: String = ""
    @objc dynamic var educationStart: Date = Date.distantPast
    @objc dynamic var educationEnd: Date = Date.distantFuture
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case phoneNumber = "phone"
        case height
        case biography
        case temperament
        case educationPeriod
    }
    
    enum EducationPeriodCodingKeys: String, CodingKey {
        case start
        case end
    }
    
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
    
    required init(from decoder: Decoder) throws
    {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.identifier = try container.decode(String.self, forKey: .identifier)
        self.name = try container.decode(String.self, forKey: .name)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.height = try container.decode(Double.self, forKey: .height)
        self.biography = try container.decode(String.self, forKey: .biography)
        self.temperament = try container.decode(String.self, forKey: .temperament)
        
        let educationPeriodContainer = try container.nestedContainer(keyedBy: EducationPeriodCodingKeys.self, forKey: .educationPeriod)
        self.educationStart = try educationPeriodContainer.decode(Date.self, forKey: .start)
        self.educationEnd = try educationPeriodContainer.decode(Date.self, forKey: .end)
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(name, forKey: .name)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(height, forKey: .height)
        try container.encode(biography, forKey: .biography)
        try container.encode(temperament, forKey: .temperament)
        
        let educationPeriodEncoder = container.superEncoder(forKey: .educationPeriod)
        var educationPeriodContainer = educationPeriodEncoder.container(keyedBy: EducationPeriodCodingKeys.self)
        try educationPeriodContainer.encode(educationStart, forKey: .start)
        try educationPeriodContainer.encode(educationEnd, forKey: .end)
    }
    
    override class func primaryKey() -> String?
    {
        return "identifier"
    }
}
