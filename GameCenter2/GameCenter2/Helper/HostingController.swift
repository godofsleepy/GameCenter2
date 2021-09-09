//
//  HostingController.swift
//  GameCenter
//
//  Created by rifat khadafy on 24/08/20.
//  Copyright © 2020 rifat khadafy. All rights reserved.
//

import Foundation
import SwiftUI

class HostingController<Content>: UIHostingController<Content> where Content : View {
//    Membuat status bar berwana putih
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
