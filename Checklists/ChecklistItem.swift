//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Fuzari on 27/05/2019.
//  Copyright © 2019 Fuzari. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}

