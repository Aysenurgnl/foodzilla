//
//  CartInteractor.swift
//  foodzilla
//
//  Created by Ayşenur on 14.12.2021.
//

import Foundation
import Alamofire
import Firebase

class SepetInteractor :PresenterToInteractorCartProtocol{
    var cartPresenter: InteractorToPresenterCartProtocol?
    
    
    func getAllFood(kullanici_adi: String) {
        let params: Parameters = ["kullanici_adi":kullanici_adi]
        
        AF.request(
            "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).responseJSON { (response) in
                if let data = response.data{
                    do {
                        let cevap = try JSONDecoder().decode(CartFoodsResponse.self, from: data)
                        var list = [CartFoods]()
                        if let comingList = cevap.sepet_yemekler{
                            list = comingList
                        }
                      
                        self.cartPresenter?.sendDataToPresenter(foodsList: list)
                        
                    }catch{
                        self.cartPresenter?.sendDataToPresenter(foodsList: [])
                        print("Hata :\(error.localizedDescription)")
                    }
                }
            }
    }
    
    func deleteFood(sepet_yemek_id: String, kullanici_adi: String) {
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).responseJSON { (response) in
            if let data = response.data{
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        print(json)
                        self.getAllFood(kullanici_adi: Auth.auth().currentUser!.uid)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
