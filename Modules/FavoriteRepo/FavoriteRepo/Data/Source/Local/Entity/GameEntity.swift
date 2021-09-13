//
//  GameEntity.swift
//  FavoriteRepo
//
//  Created by Rumah Coding on 10/09/21.
//

import Foundation
import RealmSwift

public class GameEntity: Object {
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
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
