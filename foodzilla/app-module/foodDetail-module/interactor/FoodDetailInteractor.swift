//
//  FoodDetailInteractor.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import Foundation
import Alamofire
import Firebase
import SCLAlertView

class FoodDetailInteractor:PresenterToInteractorFoodDetailProtocol{
    func addFood(yemekAdi: String, yemekResimAdi: String, yemekFiyat: Int, yemekSiparisAdet: Int, kullaniciAdi: String) {
        let params : Parameters = ["yemek_adi":yemekAdi,"yemek_resim_adi":yemekResimAdi,"yemek_fiyat":yemekFiyat,"yemek_siparis_adet":yemekSiparisAdet,"kullanici_adi":Auth.auth().currentUser!.uid]
        AF.request(
            "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: params).responseJSON { (response) in
                if let data = response.data{
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                            print(json)
                            print(data)
                            SCLAlertView().showSuccess("BAŞARILI", subTitle: "Ürün sepete eklendi.",closeButtonTitle: "Tamam")
                        }
                    }catch{
                        print(String(describing: error))
                    }
                }
            }
    }
    
    
}

