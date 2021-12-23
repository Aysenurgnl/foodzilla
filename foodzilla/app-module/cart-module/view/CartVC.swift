//
//  CartVC.swift
//  foodzilla
//
//  Created by Ayşenur on 14.12.2021.
//

import UIKit
import Alamofire
import Kingfisher
import Firebase
import SCLAlertView

class CartVC: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    
    var foodsList = [CartFoods]()
    var cartPresenterObject :ViewToPresenterCartProtocol?
  
    
    @IBOutlet weak var totalCostTitleLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var emptyCartView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyCartView.isHidden = true //empty cart
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        self.cartTableView.separatorStyle = .none
        
        CartRouter.createModule(ref: self)
        
        totalCostTitleLabel.textColor = UIColor.mainGreen
        totalCostTitleLabel.text = "Toplam Tutar"
        infoLabel.text = "Ücretsiz Teslimat"
        infoLabel.textColor = UIColor.mainGreen
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartPresenterObject?.getFoods(kullanici_adi: Auth.auth().currentUser!.uid)
        totalPrice()
        
    }
    
    func totalPrice(){
        var totalCost = 0
        var price = 0
        
        for food in foodsList{
            price = Int(food.yemek_fiyat!)! * Int(food.yemek_siparis_adet!)!
            totalCost += price
        }
        self.totalCostLabel.text = String(totalCost)
    }
   
}
extension CartVC :PresenterToViewCartProtocol{
    func sendDataToView(foodList: Array<CartFoods>) {
        self.foodsList = foodList
        if foodList.isEmpty{
            emptyCartView.isHidden = false
        }else{
            emptyCartView.isHidden = true
        }
        
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
            self.totalPrice()
        }
    }
}

extension CartVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foodsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:"cartCell",for: indexPath ) as! CartTableViewCell
        cell.foodNameLabel.text = food.yemek_adi
        cell.orderCountLabel.text = "Adet : \(food.yemek_siparis_adet!)"
        cell.foodPriceLabel.text = "\(food.yemek_fiyat!) ₺"
        
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)"){
             DispatchQueue.main.async {
                cell.foodImageView.kf.setImage(with: url)
             }
         }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { (contextualAction, view, bool) in
                let food = self.foodsList[indexPath.row]
                
                let alert = UIAlertController(title: "Silme İşlemi", message: "\(food.yemek_adi!) silinsin mi?", preferredStyle: .alert)
                let iptalAction = UIAlertAction(title: "İptal", style: .cancel) { (action) in
                  
                }
                alert.addAction(iptalAction)

                let yesAction = UIAlertAction(title: "Evet", style: .destructive) { (action) in
                        self.cartPresenterObject?.delete(sepet_yemek_id: food.sepet_yemek_id!, kullanici_adi: food.kullanici_adi!)
                        print("\(food.yemek_adi!) deleted")
                
                    
                }
                alert.addAction(yesAction)
                self.present(alert, animated: true)
           
             
        }
        deleteAction.image = UIImage(named: "delete_icon")
        deleteAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [deleteAction])
 }
}
