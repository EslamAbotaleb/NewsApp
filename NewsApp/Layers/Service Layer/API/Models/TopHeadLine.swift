//
//  TopHeadLine.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/27/21.
//


import Foundation

// MARK: - TopHeadLineModel
struct TopHeadLineModel: BaseModel {
    let status: String
    let totalResults: Int
    let articles: [Article]
}



// MARK: - Source
struct ArticleSource: BaseModel {
 
    let name: String
}
