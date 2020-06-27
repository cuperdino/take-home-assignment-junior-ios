//
//  ProductArray.swift
//  EasyShopper
//
//  Created by Sabahudin Kodro on 27/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var productsArray = [Product]()

        for key in container.allKeys {
            let product = try container.decode(Product.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            productsArray.append(product)
        }
        self.products = productsArray
    }
}
