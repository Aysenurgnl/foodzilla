//
//  HomePageRouter.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import Foundation

class HomePageRouter:PresenterToRouterHomepageProtocol{
    static func createModule(ref: HomePageVC) {
        let presenter:ViewToPresenterHomepageProtocol & InteractorToPresenterHomepageProtocol = HomePagePresenter()
        
        //ViewController
        ref.homepagePresenterObject = presenter
        
        //presenter
        ref.homepagePresenterObject?.homepageInteractor = HomePageInteractor()
        ref.homepagePresenterObject?.homepageView = ref
        
        //Interactor 
        ref.homepagePresenterObject?.homepageInteractor?.homepagePresenter = presenter
    }
    
    
}
