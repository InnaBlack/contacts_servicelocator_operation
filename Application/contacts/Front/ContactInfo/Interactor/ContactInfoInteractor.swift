//
//  ContactInfoInteractor.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import RealmSwift

extension Contact: ContactInfoItem
{
    
    var educationPeriod: String
    {
        let startDay = dateFormatter().string(from: educationStart)
        let endDay = dateFormatter().string(from: educationEnd)
        return "\(startDay) - \(endDay)"
    }
    
    func dateFormatter() -> DateFormatter
    {
        let formatter = DateFormatter.init()
        formatter.dateStyle = .medium
        return formatter
    }
}

class ContactInfoInteractor
{
    weak var output: ContactInfoInteractorOutput!
    
    var contactsService: ContactsService
    
    var contact: Contact?
    
    var notificationToken: NotificationToken?
    
    init(contactsService: ContactsService)
    {
        self.contactsService = contactsService
    }
    
    deinit
    {
        notificationToken?.invalidate()
    }
}


extension ContactInfoInteractor: ContactInfoInteractorInput
{
    func configure(with contactId: String)
    {
        if let contact = contactsService.readContact(with: contactId)
        {
            self.contact = contact
            output.interactorDidLoad(item: contact)
        }
    }
    
    func urlForCall() -> URL?
    {
        guard let contactPhone = contact?.phoneNumber else {return nil}
        
        let path = "tel://\(contactPhone)"
        return URL.init(string: path)

    }
}
