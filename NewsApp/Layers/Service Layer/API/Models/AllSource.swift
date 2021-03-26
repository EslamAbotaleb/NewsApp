//
//  AllSource.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import Foundation

// MARK: - AllSourceModel
struct AllSourceModel: BaseModel {
    let status: String
    let sources: [Source]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case sources = "sources"
    }
}

