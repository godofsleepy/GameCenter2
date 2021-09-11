//
//  Platform.swift
//  Home
//
//  Created by Rumah Coding on 11/09/21.
//

import Foundation

struct Platform : Hashable {
    let id,name,image : String
}

var dataPlatforms : [Platform] = [
    Platform(id: "187",name: "Playstation 5", image: "Playstation"),
    Platform(id: "4",name: "PC", image: "PC"),
    Platform(id: "186",name: "Xbox X", image: "Xbox"),
    Platform(id: "7",name: "Nintendo Switch", image: "Switch"),
]
