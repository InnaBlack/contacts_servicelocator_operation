//
//  Contact.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 04/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift
import Realm


class Contact: RealmSwift.Object, Decodable
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
    
    override class func primaryKey() -> String?
    {
        return "identifier"
    }
}
