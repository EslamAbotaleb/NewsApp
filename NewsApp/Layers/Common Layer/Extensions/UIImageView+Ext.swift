//
//  UIImageView+Ext.swift
//  EcwidStore
//
//  Created by Logista on 7/26/20.
//  Copyright © 2020 Logista. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImage(fromURL url:String){
           NewsServiceApi.shared.downloadImage(from: url) {[weak self] (image) in
               guard let self = self else {return}
               DispatchQueue.main.async {
                   self.image = image
               }
           }
       }
}
