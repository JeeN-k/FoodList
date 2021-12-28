//
//  FoodResponse.swift
//  FoodListMJ
//
//  Created by Oleg Stepanov on 23.12.2021.
//

import Foundation
import Firebase

protocol MealItem {
    var mealItem: MealsResponse { get }
    var ref: DatabaseReference? { get }
}

struct FoodItem: MealItem {
    var mealItem: MealsResponse
    var ref: DatabaseReference?
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        mealItem = MealsResponse(name: snapshotValue["Name"] as! String,
                         count: snapshotValue["Price"] as! String,
                         price: snapshotValue["Count"] as! String,
                         isBought: snapshotValue["Ch"] as! Bool,
                         key: snapshot.key,
                         type: .food)
        ref = snapshot.ref
    }
}

struct WaterItem: MealItem {
    var mealItem: MealsResponse
    var ref: DatabaseReference?
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        mealItem = MealsResponse(name: snapshotValue["Name"] as! String,
                         count: snapshotValue["Price"] as! String,
                         price: snapshotValue["Count"] as! String,
                         isBought: snapshotValue["Ch"] as! Bool,
                         key: snapshot.key,
                         type: .water)
        
        ref = snapshot.ref
    }
}

struct MealsResponse {
    var name: String
    var count: String
    var price: String
    var isBought: Bool
    var key: String
    var type: MealType
}

struct MealSend {
    var name: String
    var count: String
    var price: String
    var type: MealType
}

struct MealViewModel {
    struct Cell: MealCellViewModel {
        var mealItem: MealsResponse
    }
    var cells: [Cell]
}

enum MealType: String, CaseIterable {
    case food = "Еда"
    case water = "Напитки"
}
