//
//  Article.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/27/21.
//

import Foundation
// MARK: - Article
struct Article: BaseModel {
    let source: ArticleSource
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
