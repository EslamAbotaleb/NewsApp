//
//  ErrorDescription.swift
//  EtisalatSport
//
//  Created by Islam Abotaleb on 7/18/19.
//  Copyright © 2019 Mohamed Alaa El-Din. All rights reserved.
//

import Foundation

/*
 display [errorTitle, errorDescrption]
 */
class ErrorDescription {
    
    static var shared: ErrorDescription = ErrorDescription()
    private init() {}
    
    
 func displaydescriptionError(passerrorview showerrorview: BaseViewController? = nil) {
    let errorServiceLocalizations = ErrorServiceLocalizations.init(httpStatus: 0, errorType: .server)
    let errorTitle = errorServiceLocalizations.errorTitle
    let errorDescription = errorServiceLocalizations.errorDescription
//    showerrorview?.showErrorView(errorTitle: errorTitle, errorDescription: errorDescription)
}
}
