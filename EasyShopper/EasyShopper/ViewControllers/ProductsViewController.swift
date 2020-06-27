//
//  ProductsViewController.swift
//  EasyShopper
//
//  Created by Sabahudin Kodro on 27/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ProductsViewControllerDelegate: class {
    func productAdded(product: Product)
}

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: ProductsViewControllerDelegate?
    
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.getProducts()
    }

    func getProducts() {
        let networkService = NetworkService()
        networkService.callApi(endpoint: .getProducts, returnType: ProductArray.self).done { response in
            self.products = response.products
            self.tableView.reloadData()
        }.catch { error in
            print(error)
        }
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard products.count > 0 else {
            return cell
        }
        
        guard let productCell = self.tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return cell
        }
        let product = products[indexPath.row]
        
        if let imageUrl = URL(string: product.imageURL) {
            productCell.productImageView.af.setImage(withURL: imageUrl)
        }
        
        productCell.nameLabel.text = product.name
        
        return productCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard products.count > 0 else {
            return
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
        let product = self.products[indexPath.row]
        self.delegate?.productAdded(product: product)
    }
}
