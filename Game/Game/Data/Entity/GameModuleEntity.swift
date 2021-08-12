//
//  GameModuleEntity.swift
//  Game
//
//  Created by rifat khadafy on 18/02/21.
//

import Foundation
import RealmSwift

class GameModuleEntity: Object {
    @objc dynamic var id = 0
    @objc dynamic var name : String = ""
    @objc dynamic var released : String = ""
    @objc dynamic var rating : Double = 0.00
    @objc dynamic var desc : String = ""
    @objc dynamic var image : String = ""
    @objc dynamic var additionalImage : String = ""
    @objc dynamic var clip : String  = ""
    let platforms = List<String>()
    let genre = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
