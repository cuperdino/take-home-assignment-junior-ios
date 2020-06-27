//
//  ViewController.swift
//  EasyShopper
//
//  Created by Morten Bek Ditlevsen on 11/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import UIKit

#warning("""
The initial viewcontroller should show the shopping basket.
It should contain a 'Plus' button for adding new items to the basket.
It should contain a 'Clear' button for removing all items in the basket.
""")

class ShoppingBasketViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRightBarButtonItem()
        self.addLeftBarButtonItem()
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
        self.navigationController?.pushViewController(productsViewController, animated: true)
    }
    
    @objc
    func addCleared(sender: UIBarButtonItem) {
    }
}
