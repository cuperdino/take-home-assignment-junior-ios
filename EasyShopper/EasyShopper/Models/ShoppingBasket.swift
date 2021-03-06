//
//  ShoppingBasket.swift
//  EasyShopper
//
//  Created by Morten Bek Ditlevsen on 11/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation

class ShoppingBasket {
    var basketItems: [BasketItem] = []
    
    var totalPrice: Int {
        get {
            self.calculateTotalPrice()
        }
    }
    
    func addProduct(product: Product) {
        if !self.basketItems.contains(where: {$0.product == product}) {
            self.basketItems.append(BasketItem(product: product))
        }
        else {
            for item in basketItems where item.product == product {
                item.quantity += 1
            }
        }
    }
    
    func clearBasket() {
        self.basketItems = []
    }
    
    private func calculateTotalPrice() -> Int {
        var totalPrice = 0
        for item in basketItems {
            totalPrice += item.totalPrice
        }
        
        return totalPrice
    }
}

class BasketItem {
    let product: Product
    var quantity: Int
    
    var totalPrice: Int {
        get {
            return product.retailPrice * quantity
        }
    }
    
    init(product: Product, quantity: Int = 1) {
        self.product = product
        self.quantity = quantity
    }
}
