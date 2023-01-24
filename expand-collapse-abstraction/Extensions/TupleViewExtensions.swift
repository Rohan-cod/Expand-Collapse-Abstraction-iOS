//
//  TupleViewExtensions.swift
//  expand-collapse-abstraction
//
//  Created by Rohan  Gupta on 24/01/23.
//

import SwiftUI

extension TupleView {
    var getViews: [CollapsableView] {
        makeArray(from: value)
    }
    
    private struct GenericView {
        let body: Any
        
        var anyView: AnyView? {
            AnyView(_fromValue: body)
        }
    }
    
    private func makeArray<Tuple>(from tuple: Tuple) -> [CollapsableView] {
        func convert(child: Mirror.Child) -> CollapsableView {
            withUnsafeBytes(of: child.value) { ptr -> CollapsableView in
                let binded = ptr.bindMemory(to: GenericView.self)
                return binded.first?.body as! CollapsableView
            }
        }
        
        let tupleMirror = Mirror(reflecting: tuple)
        return tupleMirror.children.compactMap(convert)
    }
}

