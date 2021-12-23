//
//  HomePagePresenter.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import Foundation

class HomePagePresenter :ViewToPresenterHomepageProtocol{
    var homepageView: PresenterToViewHomepageProtocol?
    
    var homepageInteractor: PresenterToInteractorHomepageProtocol?
    
    func getTheFoods() {
        homepageInteractor?.getAllFoods()
    }
    
    
}
extension HomePagePresenter : InteractorToPresenterHomepageProtocol{
    func sendDataToPresenter(foodslist: Array<Foods>) {
        homepageView?.sendDataToView(foodsList: foodslist)
    }
    
}
