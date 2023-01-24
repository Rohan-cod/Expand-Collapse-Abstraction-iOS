//
//  CollapsableViewBuilder.swift
//  expand-collapse-abstraction
//
//  Created by Rohan  Gupta on 24/01/23.
//

import SwiftUI

@resultBuilder
struct ECViewBuilder {
    static func buildBlock(_ components: CollapsableView...) -> TupleView<[CollapsableView]> {
        TupleView(components)
    }
}

