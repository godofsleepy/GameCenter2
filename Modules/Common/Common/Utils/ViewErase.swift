//
//  ViewErase.swift
//  Common
//
//  Created by Rumah Coding on 11/09/21.
//

import SwiftUI

public extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

