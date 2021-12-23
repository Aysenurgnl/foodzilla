//
//  CartProtocols.swift
//  foodzilla
//
//  Created by Ayşenur on 14.12.2021.
//

import Foundation

protocol ViewToPresenterCartProtocol {
    var cartView:PresenterToViewCartProtocol?{get set}
    var cartInteractor:PresenterToInteractorCartProtocol?{get set}
    
    func getFoods(kullanici_adi:String)
    func delete(sepet_yemek_id:String,kullanici_adi:String)
}
protocol PresenterToInteractorCartProtocol {
    var cartPresenter:InteractorToPresenterCartProtocol?{get set}
    
    func getAllFood(kullanici_adi:String)
    func deleteFood(sepet_yemek_id:String,kullanici_adi:String)
    
}
protocol InteractorToPresenterCartProtocol {
    func sendDataToPresenter(foodsList:Array<CartFoods>)
}
protocol PresenterToViewCartProtocol {
    func sendDataToView(foodList:Array<CartFoods>)
}
protocol PresenterToRouterCartProtocol {
    static func createModule(ref:CartVC)
}
