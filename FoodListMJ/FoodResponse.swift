//
//  FoodResponse.swift
//  FoodListMJ
//
//  Created by Oleg Stepanov on 23.12.2021.
//

import Foundation
import Firebase

protocol MealItem {
    var mealItem: Meals { get }
    var ref: DatabaseReference? { get }
}

struct FoodItem: MealItem {
    var mealItem: Meals
    var ref: DatabaseReference?
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        mealItem = Meals(name: snapshotValue["Name"] as! String,
                         count: snapshotValue["Price"] as! String,
                         price: snapshotValue["Count"] as! String,
                         isBought: snapshotValue["Ch"] as! Bool,
                         key: snapshot.key,
                         type: .food)
        ref = snapshot.ref
    }
}

struct WaterItem: MealItem {
    var mealItem: Meals
    var ref: DatabaseReference?
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        mealItem = Meals(name: snapshotValue["Name"] as! String,
                         count: snapshotValue["Price"] as! String,
                         price: snapshotValue["Count"] as! String,
                         isBought: snapshotValue["Ch"] as! Bool,
                         key: snapshot.key,
                         type: .water)
        
        ref = snapshot.ref
    }
}

struct Meals {
    var name: String
    var count: String
    var price: String
    var isBought: Bool
    var key: String
    var type: FoodType
}

struct MealViewModel {
    struct Cell: MealCellViewModel {
        var mealItem: Meals
    }
    var cells: [Cell]
}

enum FoodType: String, CaseIterable {
    case food = "Еда"
    case water = "Вода"
}
