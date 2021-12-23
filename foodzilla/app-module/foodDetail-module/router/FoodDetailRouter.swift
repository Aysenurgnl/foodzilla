//
//  FoodDetailRouter.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import Foundation

class FoodDetailRouter :PresenterToRouterFoodDetailProtocol{
    static func createModule(ref: FoodDetailVC) {
        
        ref.foodDetailPresenterObject = FoodDetailPresenter()
        ref.foodDetailPresenterObject?.foodDetailInteractor = FoodDetailInteractor()
        
    }
    
    
}

