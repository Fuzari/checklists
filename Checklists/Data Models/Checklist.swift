//
//  Checklist.swift
//  Checklists
//
//  Created by Fuzari on 07/06/2019.
//  Copyright © 2019 Fuzari. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items: [ChecklistItem] = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
