//
//  CartFoodsResponse.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import Foundation


class CartFoodsResponse:Codable{
    var sepet_yemekler:[CartFoods]?
    var success:Int?
}
