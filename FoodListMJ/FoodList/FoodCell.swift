//
//  FoodCell.swift
//  FoodListMJ
//
//  Created by Oleg Stepanov on 23.12.2021.
//

import Foundation
import UIKit

protocol MealCellViewModel {
    var mealItem: Meals { get }
}

class FoodCell: UITableViewCell {
    static let reuseID = "FoodCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayer()
    }
    
    func set(foodItem: MealCellViewModel) {
        nameLabel.text = foodItem.mealItem.name
        countLabel.text = foodItem.mealItem.count + " шт"
        priceLabel.text = foodItem.mealItem.price + " Р"
        accessoryType = foodItem.mealItem.isBought ? .checkmark : .none
    }
    
    private func setupLayer() {
        addSubview(nameLabel)
        addSubview(countLabel)
        addSubview(priceLabel)
        
        selectionStyle = .none
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8).isActive = true
        
        countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        countLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
