//
//  FoodCell.swift
//  FoodListMJ
//
//  Created by Oleg Stepanov on 23.12.2021.
//

import Foundation
import UIKit

protocol MealCellViewModel {
    var mealItem: MealsResponse { get }
}

class FoodCell: UITableViewCell {
    static let reuseID = "FoodCell"
    
    let cardView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
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
        cardView.backgroundColor = foodItem.mealItem.isBought ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) : #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
    }
    
    private func setupLayer() {
        addSubview(cardView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(countLabel)
        cardView.addSubview(priceLabel)
        
        selectionStyle = .none
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        priceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -50).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -8).isActive = true
        
        countLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        countLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
