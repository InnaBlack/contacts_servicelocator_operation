//
//  ContactItem.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

protocol ContactItem {
    var identifier: String {get}
    var title: String {get}
    var subtitle: String {get}
    var detail: String {get}
}
