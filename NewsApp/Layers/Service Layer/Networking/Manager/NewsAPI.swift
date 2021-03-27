

import Foundation


public enum NewsAPI {
    
    
    //MARK:- ROOM APIs
    
    case allSources
    case topHeadline(country: String,category: String)
   

}

//MARK:- ROOM ENDPOINTs

extension NewsAPI: EndPointType {
    
    // Base URL Constructor
    var environmentBaseURL : String {
        return "https://newsapi.org/v2/"
    }
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
        
    }
    
    // URL Paths
    
    var path: String {
        switch self {
        case .allSources:
            return "sources"
        case .topHeadline:
            return "top-headlines"
      
        }
    }
    
   
    //MARK:- BODY PARAMETERS
    
    var bodyParameters: [String:Any]?{
        switch self {
        case .allSources, .topHeadline:
            return nil
            
        }
    }
    

    var urlParameters: Parameters?{
        switch self {
        case .allSources :
            var parameter: Parameters = [String : Any]()
            parameter["apiKey"] = Keys.apiKey
            return parameter
        case .topHeadline(let country,let category):
            var parameter: Parameters = [String : Any]()
            parameter["country"] = country
            parameter["category"] = category

            parameter["apiKey"] = Keys.apiKey
            return parameter
        }
    }
    //MARK:- CONFIGURE REQUESTS
    var httpMethod: HTTPMethod {
             return .get
         }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var task: HTTPTask {
        switch self {            
        case .allSources, .topHeadline:
            return .requestParameters(bodyParameters: bodyParameters, bodyEncoding: .urlEncoding, urlParameters: urlParameters)

        }
    }
    
}
