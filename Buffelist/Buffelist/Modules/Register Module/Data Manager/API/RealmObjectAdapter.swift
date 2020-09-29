//
//  RealmObjectAdapter.swift
//  Buffelist
//
//  Created by Arda Onat on 29.09.2020.
//

import RealmSwift

class RealmObjectAdapter<T: Object> {

    func objects() -> Results<T>? {
        return try? Realm().objects(T.self)
    }

    @discardableResult func create(_ value: [String: Any]? = nil, completion: (()->())? = nil) throws -> T {
        let object = T()

        if let value = value {
            object.setValuesForKeys(value)
        }

        try add(object, completion: completion)
        return object
    }

    func add(_ object: T, completion: (()->())? = nil) throws {
        try RealmService.add(object, completion: completion)
    }

    func edit(_ object: T, set value: [String: Any]) throws {
        let realm = try Realm()
        try realm.safeWrite {
            object.setValuesForKeys(value)
        }
    }

    func remove(_ object: T) throws {
        try RealmService.remove(object)
    }
}
