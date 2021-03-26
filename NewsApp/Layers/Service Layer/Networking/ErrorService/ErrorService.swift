import Foundation

enum ErrorType: String {
    case server
    case parse
    case network
    case unknown
}

class ErrorService {

    var errorType: ErrorType
    var httpStatusCode: Int?
    var error: Error?
    var data: Data?
    
    init() {
        httpStatusCode = nil
        error = nil
        data = nil
        errorType = .unknown
    }
    
    required convenience init(errorType: ErrorType, httpStatus: Int?, error: Error?, data: Data?) {
        self.init()
        self.errorType = errorType
        self.httpStatusCode = httpStatus
        self.error = error
        self.data = data
    }
    
  
}
