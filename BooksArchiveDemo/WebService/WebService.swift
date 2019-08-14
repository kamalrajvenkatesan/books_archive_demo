//
//  WebService.swift
//  BooksArchiveDemo
//
//  Created by kamalraj venkatesan on 14/08/19.
//  Copyright © 2019 kamalraj venkatesan. All rights reserved.
//

import Foundation
import Alamofire

public class WebService {
    
    weak var request: DataRequest?
    
    public init() {}
    
    public func request<T: Codable>(responseType: T.Type, route: ApiRoute, param: [String : Any]?, completion: @escaping (( T?, BookssAppErrors?, Int? ) -> Void)) {
        
        let details = route.getDetails()
        
        self.request = Alamofire.request(details.path, method: details.method, parameters: param, encoding: details.encoding, headers: nil).responseCodable(keyPath: nil, completionHandler: { (response: DataResponse<T>) in
            
            let errorCode = (response.result.error as NSError?)?.code
            completion(response.result.value, getWebServiceError(errorCode), response.response?.statusCode)
        })
    }
    
    /** Cancel API Call */
    public func cancelRequest() {
        self.request?.cancel()
    }
}



//MARK: Alamofire Codable

extension DataRequest {
    @discardableResult
    public func responseCodable<T: Codable>(queue: DispatchQueue? = nil, keyPath: String? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self  {
        
        return response(queue: queue, responseSerializer: codableSerialization(keyPath: keyPath), completionHandler: completionHandler)
        
    }
}

public func codableSerialization<T: Codable> (keyPath: String? = nil) -> DataResponseSerializer<T> {
    
    return DataResponseSerializer(serializeResponse: { (request, response, data, error) in
        
        guard error == nil else { return .failure(error!) }
        
        guard let validData = data, validData.count > 0 else {
            return .failure(AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
        }
        
        do {
            let decoder = JSONDecoder()
            let json = try decoder.decode(T.self, from: validData)
            return .success(json)
        } catch {
            return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
        }
    })
    
}
