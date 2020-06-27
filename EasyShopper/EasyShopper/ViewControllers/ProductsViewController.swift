//
//  ProductsViewController.swift
//  EasyShopper
//
//  Created by Sabahudin Kodro on 27/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = NetworkService()
        networkService.callApi(endpoint: .getProducts, returnType: Product.self).done { products in
            print(products)
        }.catch { error in
            print(error)
        }
    }

}
