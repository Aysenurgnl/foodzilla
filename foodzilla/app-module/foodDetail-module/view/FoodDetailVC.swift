//
//  FoodDetailVC.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import UIKit
import Kingfisher
import Alamofire
import FirebaseAuth

class FoodDetailVC: UIViewController {
    
    var comingFood : Foods?
    var food:CartFoods?

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodCostLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodDescriptionLabel: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    var foodDetailPresenterObject:ViewToPresenterFoodDetailProtocol?
    
    var amount:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FoodDetailRouter.createModule(ref:self)
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(comingFood!.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                self.foodImageView.kf.setImage(with: url)
            }
        }
        
        foodNameLabel.text = comingFood!.yemek_adi!
        foodCostLabel.text = "\((comingFood!.yemek_fiyat)!) ₺"
        amountLabel.text = "\(amount)"
        foodDescriptionLabel.text = comingFood!.yemek_adi!
        
        initViews()

    }
    func initViews(){
        mainView.layer.cornerRadius = 40
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [ .layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        amountView.layer.cornerRadius = 24
        
        view1.layer.cornerRadius = 20
        view1.clipsToBounds = true
        
        view2.layer.cornerRadius = 20
        view2.clipsToBounds = true
        
        view3.layer.cornerRadius = 20
        view3.clipsToBounds = true
    }
    
    @IBAction func amountDecreaseButton(_ sender: Any) {
        //-
        if amount > 1{
            amount -= 1
            amountLabel.text = "\(amount)"
            let currentPrice = (Int((comingFood!.yemek_fiyat!))!)*amount
            foodCostLabel.text = String("\(currentPrice) ₺")
        }
    }
    
    @IBAction func amountIncreaseButton(_ sender: Any) {
        //+
        amount += 1
        amountLabel.text = "\(amount)"
        let currentPrice = (Int((comingFood!.yemek_fiyat!))!)*amount
        foodCostLabel.text = String("\(currentPrice) ₺")
        
    }
    @IBAction func addToCartButton(_ sender: Any) {
        foodDetailPresenterObject?.add(yemekAdi: comingFood!.yemek_adi!, yemekResimAdi: comingFood!.yemek_resim_adi!, yemekFiyat: Int(comingFood!.yemek_fiyat!)!, yemekSiparisAdet: amount, kullaniciAdi: Auth.auth().currentUser!.uid)
       
    }
}
