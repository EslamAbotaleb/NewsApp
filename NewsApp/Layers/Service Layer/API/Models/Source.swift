//
//  Source.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import Foundation
// MARK: - Source
struct Source: BaseModel, Hashable {
    let id: String
    let name: String
    let sourceDescription: String
    let url: String
    let category: String
    let language: String
    let country: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case sourceDescription = "description"
        case url = "url"
        case language = "language"
        case country = "country"
        case category = "category"


    }
}
