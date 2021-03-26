//
//  extension + resuable fortableview + collectionview.swift
//  Orange Sports
//
//  Created by Islam Abotaleb on 8/13/19.
//  Copyright © 2019 Islam Abotaleb. All rights reserved.
//

import Foundation
extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
