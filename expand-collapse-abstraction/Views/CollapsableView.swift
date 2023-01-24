//
//  CollapsableView.swift
//  expand-collapse-abstraction
//
//  Created by Rohan  Gupta on 23/01/23.
//

import SwiftUI

struct CollapsableView: View {
    var expanded: AnyView
    var collapsed: Binding<String>
    var buttonText: String
    var collpasedColor: Color
    
    @ObservedObject var collpasableViewModel: CollapsableViewModel = CollapsableViewModel()
    
    init(expanded: AnyView, collapsed: Binding<String>, buttonText: String, collapsedColor: Color) {
        self.expanded = expanded
        self.collapsed = collapsed
        self.buttonText = buttonText
        self.collpasedColor = collapsedColor
    }

    var body: some View {
        expanded
    }
    
    // MARK:- Helper Functions
    
    func isCollapsed() -> Bool {
        collpasableViewModel.isCollapsed()
    }
    
    func isExpanded() -> Bool {
        collpasableViewModel.isExpanded()
    }
    
    func getID() -> UUID {
        collpasableViewModel.getID()
    }
    
    func collapse() {
        collpasableViewModel.collapse()
    }
    
    func expand() {
        collpasableViewModel.expand()
    }
}
