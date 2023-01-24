//
//  CollapsableViewModel.swift
//  expand-collapse-abstraction
//
//  Created by Rohan  Gupta on 23/01/23.
//

import SwiftUI

class CollapsableViewModel: ObservableObject {
    @Published var model: CollapsableModel = CollapsableModel()
    
    
    // MARK:- Helper Functions
    
    func isCollapsed() -> Bool {
        self.model.collapsed
    }
    
    func isExpanded() -> Bool {
        !self.model.collapsed
    }
    
    func collapse() {
        self.model.collapsed = true
    }
    
    func expand() {
        self.model.collapsed = false
    }
    
    func getID() -> UUID {
        self.model.id
    }
}
