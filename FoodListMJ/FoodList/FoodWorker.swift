//
//  FoodWorker.swift
//  FoodListMJ
//
//  Created by Oleg Stepanov on 23.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Firebase

protocol FoodWorkingLogic {
    func getFood(completion: @escaping ([MealItem]) -> ())
    func selectFood(mealItem: Meals, isBought: Bool)
    func deleteFood(mealItem: Meals)
}

class FoodService: FoodWorkingLogic {
    var ref: DatabaseReference = Database.database().reference()
    
    func getFood(completion: @escaping ([MealItem]) -> ()) {
        ref.observe(.value) { [weak self] (snapshot) in
            var meals: [MealItem] = []
            self?.appendMealItems(meals: &meals, snapshot: snapshot)
            completion(meals)
        }
    }
    
    func selectFood(mealItem: Meals, isBought: Bool) {
        var childUpdates = [String: Any]()
        if mealItem.type == .food {
            childUpdates = ["/food/\(mealItem.key)/Ch": isBought]
        } else {
            childUpdates = ["/wather/\(mealItem.key)/Ch": isBought]
        }
        ref.updateChildValues(childUpdates)
    }
    
    func deleteFood(mealItem: Meals) {
        var delRef = ref
        if mealItem.type == .food {
            delRef = delRef.child("/food/\(mealItem.key)")
        } else {
            delRef = delRef.child("/wather/\(mealItem.key)")
            print(delRef)
        }
        delRef.removeValue()
    }
    
    private func appendMealItems(meals: inout [MealItem], snapshot: DataSnapshot) {
        let foodSnapshot = snapshot.childSnapshot(forPath: "food")
        for item in foodSnapshot.children {
            let meal = FoodItem(snapshot: item as! DataSnapshot)
            meals.append(meal)
        }
        
        let drinkSnapshot = snapshot.childSnapshot(forPath: "wather")
        for item in drinkSnapshot.children {
            let meal = WaterItem(snapshot: item as! DataSnapshot)
            meals.append(meal)
        }
    }
}
