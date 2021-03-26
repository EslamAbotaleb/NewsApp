import Foundation

class ErrorServiceLocalizations {

    var errorTitle: String
    var errorDescription: String
    
    init() {
        errorTitle = "Error"
        errorDescription = "Please check your internet connection!"
        if Localizer.isArabic() {
            errorDescription = "يرجى التحقق من اتصالك بالانترنت!"
        }
    }
    
    required convenience init(httpStatus: Int?, errorType: ErrorType) {
        self.init()
        setErrorTitle(errorType: errorType)
        
        if let statusCode = httpStatus{
            setErrorDescription(httpStatus: statusCode)
        }
        else{
            self.errorDescription = "Please check your internet connection!"
            if Localizer.isArabic() {
                self.errorDescription = "يرجى التحقق من اتصالك بالانترنت!"
            }
        }
    }
    
    private func setErrorTitle(errorType: ErrorType){
        switch errorType {
        case .parse:
            self.errorTitle = "Parse Error"
        case .network:
            self.errorTitle = "Network Error"
        case .server:
            self.errorTitle = "Server Error"
        default:
            self.errorTitle = "Error"
        }
    }
    
    private func setErrorDescription(httpStatus: Int){
        switch httpStatus {
        case 401:
            self.errorDescription = "401 description"
        case 402:
            self.errorDescription = "402 description"
        case 403:
            self.errorDescription = "403 description"
        default:
            self.errorDescription = "Please check your internet connection!"
            if Localizer.isArabic() {
                self.errorDescription = "يرجى التحقق من اتصالك بالانترنت!"
            }
        }
    }
    
}
