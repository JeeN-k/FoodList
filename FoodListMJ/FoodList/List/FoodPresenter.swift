//
//  FoodPresenter.swift
//  FoodListMJ
//
//  Created by Oleg Stepanov on 23.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FoodPresentationLogic {
    func presentData(response: Food.FetchFood.Response)
}

class FoodPresenter: FoodPresentationLogic {
    weak var viewController: FoodDisplayLogic?
    
    func presentData(response: Food.FetchFood.Response) {
        let food = response.mealItems
        let cells = food.map { mealItem in
            cellViewModel(from: mealItem)
        }
        let mealViewModel = MealViewModel.init(cells: cells)
        let viewModel = Food.FetchFood.ViewModel(mealViewModel: mealViewModel)
        viewController?.displayFood(viewModel: viewModel)
    }
    
    private func cellViewModel(from mealItem: MealItem) -> MealViewModel.Cell {
        return MealViewModel.Cell.init(mealItem: mealItem.mealItem)
    }
    
}
