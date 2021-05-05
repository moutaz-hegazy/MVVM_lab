//
//  NetworkLayer.swift
//  MVP_Lab
//
//  Created by moutaz hegazy on 5/3/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation

class NetworkModel{
    
//    static let shared = NetworkModel()
    
    private init(){}

    
    static func fetch(fromUrl urlStr:String , with handler : (([Movie]?,NSError?)->())? = nil)
    {

        let url = URL(string: urlStr)

        DispatchQueue.global(qos: .userInitiated).async{
                guard let dataUrl = url,
                    let webJson = try? String(contentsOf: dataUrl),
                    let jsonData = webJson.data(using: .utf8),
                    let movies = try? JSONDecoder().decode([Movie].self, from: jsonData)
                    else
                {
                    handler?(nil,NSError())
                    print(">>> FAILED")
                    return
                }
                print(">>>> Success")
                DispatchQueue.main.async{
                    handler?(movies,nil)
                }
        }
    }
}
