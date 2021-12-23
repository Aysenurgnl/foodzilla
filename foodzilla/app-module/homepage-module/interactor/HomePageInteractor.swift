//
//  HomePageInteractor.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import Foundation
import Alamofire

class HomePageInteractor:PresenterToInteractorHomepageProtocol{
    var homepagePresenter: InteractorToPresenterHomepageProtocol?
    
    func getAllFoods() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).responseJSON { (response) in
            if let data = response.data{
                do {
                    let res = try JSONDecoder().decode(FoodsResponse.self, from: data)
                    var list = [Foods]()
                    if let comingList = res.yemekler{
                        list = comingList
                    }
                    self.homepagePresenter?.sendDataToPresenter(foodslist: list)
                }catch{
                    print(String(describing: error))
                }
            }
        }
    }
    
    
}
