//
//  FoodModels.swift
//  FoodListMJ
//
//  Created by Oleg Stepanov on 23.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Food {
    
    enum FetchFood {
        struct Request {
        }
        struct Response {
            var mealItems: [MealItem]
        }
        struct ViewModel {
            var mealViewModel: MealViewModel
        }
    }

    enum SelectMeal {
        struct Request {
            var mealItem: MealsResponse
            var isBought: Bool
        }
    }
    
    enum DeleteMeal {
        struct Request {
            var mealItem: MealsResponse
        }
    }
  
}
