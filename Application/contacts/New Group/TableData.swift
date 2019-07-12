//
//  TableData.swift
//  contacts
//
//  Created by Nikolay Gladkovskiy on 06/02/2019.
//  Copyright © 2019 Nikolay Gladkovskiy. All rights reserved.
//

import Foundation

class TableSection {
    let items: [Any]
    let title: String
    
    init(items: [Any], title: String = "") {
        self.items = items
        self.title = title
    }
}

class TableData {
    var sections: [TableSection]
    
    init(sections: [TableSection]) {
        self.sections = sections
    }
    
    func numberOfItems() -> Int {
        var count = 0
        
        for section in sections
        {
            count += section.items.count
        }
        
        return count
    }
    
    func item(for indexPath: IndexPath) -> Any? {
        guard indexPath.section < sections.count else {return nil}
        let section = sections[indexPath.section]
        
        guard indexPath.row < section.items.count else {return nil}
        return section.items[indexPath.row]
    }
}
