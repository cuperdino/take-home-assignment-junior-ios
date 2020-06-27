//
//  ViewController.swift
//  EasyShopper
//
//  Created by Morten Bek Ditlevsen on 11/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import UIKit
class ShoppingBasketViewController: UIViewController {
    
    let shoppingBasket = ShoppingBasket()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRightBarButtonItem()
        self.addLeftBarButtonItem()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func addRightBarButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Plus", style: .plain, target: self, action: #selector(addTapped))
    }
    
    func addLeftBarButtonItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(addCleared))
    }
      
    @objc
    func addTapped(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let productsViewController = storyboard.instantiateViewController(withIdentifier: "ProductsViewController") as? ProductsViewController else {
            return
        }
        productsViewController.delegate = self
        self.navigationController?.pushViewController(productsViewController, animated: true)
    }
    
    @objc
    func addCleared(sender: UIBarButtonItem) {
        self.shoppingBasket.clearBasket()
        self.tableView.reloadData()
    }
    
    func createShoppingItemTableViewCell(indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItemTableViewCell", for: indexPath) as? ShoppingItemTableViewCell else {
            return defaultCell
        }
        
        let item = shoppingBasket.basketItems[indexPath.row]
        
        if let imageUrl = URL(string: item.product.imageURL) {
            cell.shoppingItemImageView?.af.setImage(withURL: imageUrl)
        }
        
        cell.nameLabel.text = item.product.name
        cell.quantityLabel.text = "Quantity: \(item.quantity)"
        
        return cell
    }
}

extension ShoppingBasketViewController: ProductsViewControllerDelegate {
    func productAdded(product: Product) {
        self.shoppingBasket.addProduct(product: product)
        dump(shoppingBasket.basketItems)
    }
}

extension ShoppingBasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard self.shoppingBasket.basketItems.count > 0 else {
            return 0
        }
        return ShoppingCartSection.sectionsCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.shoppingBasket.basketItems.count > 0 else {
            return 0
        }
        let section = ShoppingCartSection(rawValue: section)
        
        switch section {
        case .products: return shoppingBasket.basketItems.count
        case .checkoutTotal: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        guard self.shoppingBasket.basketItems.count > 0 else {
            return defaultCell
        }
        
        let section = ShoppingCartSection(rawValue: indexPath.section)
        
        switch section {
        case .products: return self.createShoppingItemTableViewCell(indexPath: indexPath)
        case .checkoutTotal:
            defaultCell.textLabel?.text = "Total price: \(shoppingBasket.totalPrice)"
            return defaultCell
        default: return defaultCell
        }
    }
}

enum ShoppingCartSection: Int {
    case products, checkoutTotal, sectionsCount
}
