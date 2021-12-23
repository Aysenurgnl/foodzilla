//
//  HomePageVC.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import UIKit
import Alamofire
import Kingfisher

class HomePageVC: UIViewController {

    @IBOutlet weak var foodsCollectionView: UICollectionView!
    @IBOutlet weak var topNameView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view3: UIView!
    
    var foodsList = [Foods]()
    var homepagePresenterObject:ViewToPresenterHomepageProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.foodsCollectionView.register(FoodsCollectionViewCell.nib, forCellWithReuseIdentifier: "foodCollectionViewCell")
        initViews()
        
        HomePageRouter.createModule(ref:self)
        
        foodsCollectionView.delegate = self
        foodsCollectionView.dataSource = self
        
        self.foodsCollectionView.isPagingEnabled = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        homepagePresenterObject?.getTheFoods()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let food = sender as? Foods
            let destinationVC = segue.destination as! FoodDetailVC
            destinationVC.comingFood = food
        }
    }
    func initViews() {
        topNameView.layer.cornerRadius = topNameView.frame.size.width/2
        topNameView.clipsToBounds = true
        
        mainView.layer.cornerRadius = 20
        mainView.clipsToBounds = true
        
        view1.layer.cornerRadius = 20
        view1.clipsToBounds = true
        
        view2.layer.cornerRadius = 20
        view2.clipsToBounds = true
        
        view3.layer.cornerRadius = 20
        view3.clipsToBounds = true
        
        let genislik = foodsCollectionView.frame.size.width
        
        let tasarim = UICollectionViewFlowLayout()
        
        tasarim.sectionInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        
        tasarim.minimumInteritemSpacing = 5
        tasarim.minimumLineSpacing = 10
        
        tasarim.itemSize = CGSize(width: (genislik-85)/2, height: (genislik-85)/2)
        foodsCollectionView.collectionViewLayout = tasarim
    }
    

}
extension HomePageVC:PresenterToViewHomepageProtocol{
    func sendDataToView(foodsList: Array<Foods>) {
        self.foodsList = foodsList
        DispatchQueue.main.async {
            self.foodsCollectionView.reloadData()
        }
    }
}

extension HomePageVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodsList.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let food = foodsList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCollectionViewCell", for: indexPath) as! FoodsCollectionViewCell
        cell.foodNameLabel.text = "\(food.yemek_adi!)"
        cell.foodCostLabel.text = "\(food.yemek_fiyat!) ₺"
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                cell.foodImageView.kf.setImage(with: url)
            }
        }
        cell.layer.cornerRadius = 20
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0, height: 237.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = self.foodsList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: food)
        
        
    }
    
}
