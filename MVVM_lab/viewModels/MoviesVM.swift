//
//  MoviesVM.swift
//  MVVM_lab
//
//  Created by moutaz hegazy on 5/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation

class MoviesVM{
    var moviesOnSuccessBinder : ([Movie])->()
    var moviesOnFailureBinder : ()->()
    
    init(onSuccess : @escaping ([Movie])->() , onFailure : @escaping ()->()) {
        moviesOnSuccessBinder = onSuccess
        moviesOnFailureBinder = onFailure
        NetworkModel.fetch(fromUrl: Urls.MoviesUrl) {
            [weak self]
            (movies, error) in
            if(error != nil){
                DispatchQueue.main.async {
                    self?.moviesOnFailureBinder()
                }
                return
            }
            
            self?.moviesOnSuccessBinder(movies ?? [])
        }
    }
}
