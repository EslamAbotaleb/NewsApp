import Foundation

enum NetworkServiceResult<ResponseModel: BaseModel, ErrorModel: ErrorService> {
    case successModel(ResponseModel)
    case successArray([ResponseModel])
    case failure(ErrorModel)
}
