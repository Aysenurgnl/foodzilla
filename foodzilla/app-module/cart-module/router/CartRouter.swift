//
//  CartRouter.swift
//  foodzilla
//
//  Created by Ayşenur on 14.12.2021.
//

import Foundation


class CartRouter : PresenterToRouterCartProtocol{
    static func createModule(ref: CartVC) {
        
        let presenter:ViewToPresenterCartProtocol & InteractorToPresenterCartProtocol = CartPresenter()
        
        ref.cartPresenterObject = presenter
        
        ref.cartPresenterObject?.cartInteractor = SepetInteractor()
        ref.cartPresenterObject?.cartView = ref
        
        ref.cartPresenterObject?.cartInteractor?.cartPresenter = presenter
        
    }
}
