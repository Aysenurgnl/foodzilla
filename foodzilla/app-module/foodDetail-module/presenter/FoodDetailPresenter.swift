//
//  FoodDetailPresenter.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import Foundation


class FoodDetailPresenter :ViewToPresenterFoodDetailProtocol {
    var foodDetailInteractor: PresenterToInteractorFoodDetailProtocol?
    
    func add(yemekAdi: String, yemekResimAdi: String, yemekFiyat: Int, yemekSiparisAdet: Int, kullaniciAdi: String) {
        foodDetailInteractor?.addFood(yemekAdi: yemekAdi, yemekResimAdi: yemekResimAdi, yemekFiyat: yemekFiyat, yemekSiparisAdet: yemekSiparisAdet, kullaniciAdi: kullaniciAdi)
    }
    

}

