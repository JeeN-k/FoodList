//
//  FieldsView.swift
//  FoodListMJ
//
//  Created by Oleg Stepanov on 28.12.2021.
//

import Foundation
import UIKit

class FieldsView: UIView {
    
    let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.clipsToBounds = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Наименование"
        textfield.layer.cornerRadius = 5
       return textfield
    }()
    
    let countTextField: UITextField = {
        let textfield = UITextField()
        textfield.clipsToBounds = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Количество"
        textfield.keyboardType = .numberPad
        textfield.layer.cornerRadius = 5
       return textfield
    }()
    
    let priceTextField: UITextField = {
        let textfield = UITextField()
        textfield.clipsToBounds = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Цена"
        textfield.keyboardType = .decimalPad
        textfield.layer.cornerRadius = 5
       return textfield
    }()
    
    let typeControl: UISegmentedControl = {
        let segcontrol = UISegmentedControl(items: ["Еда", "Напитки"])
        segcontrol.selectedSegmentIndex = 0
        segcontrol.clipsToBounds = true
        segcontrol.layer.cornerRadius = 5
        segcontrol.translatesAutoresizingMaskIntoConstraints = false
        return segcontrol
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupConstraints()
    }
    
    func clearFields() {
        nameTextField.text = ""
        countTextField.text = ""
        priceTextField.text = ""
        typeControl.selectedSegmentIndex = 0
        
        nameTextField.becomeFirstResponder()
    }
    
    func getData() -> MealSend? {
        guard let name = nameTextField.text, name != "",
                let count = countTextField.text, count != "",
                let price = priceTextField.text, price != "" else { return nil }
        let mealType: MealType = typeControl.selectedSegmentIndex == 0 ? .food : .water
        return MealSend(name: name, count: count, price: price, type: mealType)
    }
    
    private func setupConstraints() {
        addSubview(nameTextField)
        addSubview(countTextField)
        addSubview(priceTextField)
        addSubview(typeControl)
        
        nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        countTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16).isActive = true
        countTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        countTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        countTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        priceTextField.topAnchor.constraint(equalTo: countTextField.bottomAnchor, constant: 16).isActive = true
        priceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        priceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        priceTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        typeControl.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 16).isActive = true
        typeControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        typeControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        typeControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
