//
//  ContactItem.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

protocol ContactInfoItem {
    var identifier: String {get}
    var name: String {get}
    var phoneNumber: String {get}
    var biography: String {get}
    var temperament: String {get}
    var educationPeriod: String {get}
}
