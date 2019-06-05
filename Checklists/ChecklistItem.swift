//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Fuzari on 27/05/2019.
//  Copyright © 2019 Fuzari. All rights reserved.
//

import Foundation

//  Description of checklistItem object
class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}

