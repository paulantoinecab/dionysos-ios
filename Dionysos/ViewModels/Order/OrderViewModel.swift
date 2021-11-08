//
//  OrderViewModel.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 12/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import SwiftUI

class OrderViewModel: ObservableObject {
    @Published private(set) var order: [UUID:Food] = [:]
    @Published private(set) var productCount: Int = 0
    @Published private(set) var sumForFood: Double = 0.0
    @Published private(set) var total: Double = 0.0
    @Published private(set) var stripeTotal: Int = 0
    @Published private(set) var restaurant: Restaurant
    @Published private(set) var table: Table
    @Published private(set) var selectedFood: Food? = nil
    @Published private(set) var errorMessage: String? = nil
    
    
    init(restaurant: Restaurant, table: Table) {
        self.restaurant = restaurant
        self.table = table
    }
    
    
    func addFoodToOrder(food: Food) {
        if var food = order[food.id] {
            food.quantity += 1
            order[food.id] = food
        } else {
            var food = food
            food.quantity = 1
            order[food.id] = food
        }
        refresh()
    }
        
    func minusFoodToOrder(food: Food) {
        if let food = order[food.id], food.quantity == 1 {
            order.removeValue(forKey: food.id)
        } else {
            var food = food
            food.quantity -= 1
            order[food.id] = food
        }
        refresh()
    }
    
    func removeFoodFromOrder(food: Food) {
        order.removeValue(forKey: food.id)
        refresh()
    }
    
    func removeSelectedFoodFromOrder() {
        guard let selectedFood = self.selectedFood else { return }
        removeFoodFromOrder(food: selectedFood)
        self.selectedFood = nil
        refresh()
    }
    
    func emptyOrder() {
        order = [:]
        refreshCount()
    }
    
    func refreshCount() {
        productCount = order.reduce(0, {
            $0 + $1.value.quantity
        })
    }
    
    func selectFood(food: Food) {
        self.selectedFood = order[food.id]
        refreshSumForFood()
    }
    
    func refreshSum() {
        self.total = order.reduce(0, {$0 + $1.value.price * Double($1.value.quantity)})
        self.stripeTotal = Int(total * 100)
    }
    
    func refreshSumForFood() {
        guard let selectedFood = selectedFood else { return }
        self.sumForFood = selectedFood.price * Double(selectedFood.quantity)
    }
    
    func unselectFood() {
        selectedFood = nil
    }
    
    func incrementSelectedFood() {
        guard let selectedFood = self.selectedFood else { return }
        self.addFoodToOrder(food: selectedFood)
        selectFood(food: selectedFood)
        refresh()
    }
    
    func decrementSelectedFood() {
        guard let selectedFood = self.selectedFood else { return }
        if selectedFood.quantity > 1 {
            self.minusFoodToOrder(food: selectedFood)
            selectFood(food: selectedFood)
        }
        refresh()
    }
    
    func refresh() {
        refreshCount()
        refreshSum()
    }
    
    func placeOrder() -> Order {
        let foods = order.values.map({OrderFood(id: $0.id, quantity: $0.quantity)})
        return Order(table: table, foods: foods)
    }
}
