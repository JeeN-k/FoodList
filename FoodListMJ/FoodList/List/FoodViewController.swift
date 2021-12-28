//
//  FoodViewController.swift
//  FoodListMJ
//
//  Created by Oleg Stepanov on 23.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FoodDisplayLogic: AnyObject {
    func displayFood(viewModel: Food.FetchFood.ViewModel)
}

class FoodViewController: UIViewController, FoodDisplayLogic {
    
    var interactor: FoodBusinessLogic?
    var router: (NSObjectProtocol & FoodRoutingLogic)?
    
    let table = UITableView()
    
    var meals: MealViewModel = MealViewModel.init(cells: [])
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = FoodInteractor()
        let presenter             = FoodPresenter()
        let router                = FoodRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchRequestFood()
    }
    
    private func fetchRequestFood() {
        let request = Food.FetchFood.Request()
        interactor?.makeFoodRequest(request: request)
    }
    
    func displayFood(viewModel: Food.FetchFood.ViewModel) {
        meals = viewModel.mealViewModel
        table.reloadData()
    }
    
    private func selectItem(item: MealsResponse, selectionStyle: Bool) {
        let request = Food.SelectMeal.Request(mealItem: item, isBought: selectionStyle)
        interactor?.selectFoodItem(request: request)
    }
    
    private func deleteItem(item: MealsResponse) {
        let request = Food.DeleteMeal.Request(mealItem: item)
        interactor?.deleteFoodItem(request: request)
    }
    
    @objc func doSome() {
        performSegue(withIdentifier: "segue", sender: nil)
    }
}

extension FoodViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.cells.filter({ $0.mealItem.type == MealType.allCases[section]}).count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MealType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return MealType.allCases[section].rawValue
        } else {
            return MealType.allCases[section].rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.reuseID, for: indexPath) as! FoodCell
        let cellViewModel = meals.cells.filter({ $0.mealItem.type == MealType.allCases[indexPath.section] })[indexPath.row]
        cell.set(foodItem: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = meals.cells.filter({ $0.mealItem.type == MealType.allCases[indexPath.section] })[indexPath.row].mealItem
        selectItem(item: meal, selectionStyle: !meal.isBought)
        table.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let meal = meals.cells.filter({ $0.mealItem.type == MealType.allCases[indexPath.section] })[indexPath.row].mealItem
            deleteItem(item: meal)
        }
    }
}

extension FoodViewController {
    private func setupView() {
        setupTable()
        view.addSubview(table)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Список продуктов"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(doSome))
        navigationItem.setRightBarButton(addButton, animated: true)
        
        setupConstraints()
    }
    
    private func setupTable() {
        table.register(FoodCell.self, forCellReuseIdentifier: FoodCell.reuseID)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        
    }
    
    private func setupConstraints() {
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
