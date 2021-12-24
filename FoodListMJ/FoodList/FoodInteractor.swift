//
//  FoodInteractor.swift
//  FoodListMJ
//
//  Created by Oleg Stepanov on 23.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FoodBusinessLogic {
    func makeFoodRequest(request: Food.FetchFood.Request)
    func selectFoodItem(request: Food.SelectMeal.Request)
    func deleteFoodItem(request: Food.DeleteMeal.Request)
}

protocol FoodDataStore {
    var food: [MealItem] { get set }
}

class FoodInteractor: FoodBusinessLogic, FoodDataStore {
    var food: [MealItem] = []
    
    var presenter: FoodPresentationLogic?
    lazy var service: FoodWorkingLogic = FoodService()
    
    func makeFoodRequest(request: Food.FetchFood.Request) {
        service.getFood(completion: { meal in
            self.presenter?.presentData(response: Food.FetchFood.Response(mealItems: meal))
        })
    }
    
    func selectFoodItem(request: Food.SelectMeal.Request) {
        service.selectFood(mealItem: request.mealItem, isBought: request.isBought)
    }
    
    func deleteFoodItem(request: Food.DeleteMeal.Request) {
        service.deleteFood(mealItem: request.mealItem)
    }
    
}
