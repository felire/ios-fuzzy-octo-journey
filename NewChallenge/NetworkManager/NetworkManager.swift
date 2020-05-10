//
//  NetworkManager.swift
//  NewChallenge
//
//  Created by Felipe Rodriguez on 03/05/2020.
//  Copyright © 2020 Felipe Rodriguez. All rights reserved.
//

import Alamofire

struct AuthStruct: Decodable {
    var auth: Bool
    var token: String
    
    enum CodingKeys: String, CodingKey {
      case auth
      case token
    }
}

func auth(){
    let authRepository: AuthRepository = AuthRepository()
    let token: String? = authRepository.getToken();
    if(token == nil){
        let parameters: [String: String] = [
                "apiKey": "23567b218376f79d9415"
            ]
            AF.request("http://195.39.233.28:8035/auth", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: AuthStruct.self) { response in
                switch response.result {
                case .success:
                    response.value.map({value in
                        authRepository.storeInfo(token: value.token)
                    })
        
                case .failure(let error):
                    print(error)
                }
            }
    }

}

func getImages(successCallback: @escaping (Images) -> Void, page: Int){
    let authRepository: AuthRepository = AuthRepository()
    let token: String? = authRepository.getToken();
    token.map({token in
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        AF.request("http://195.39.233.28:8035/images?page=\(page)", method: .get, headers: headers).validate().responseDecodable(of: Images.self) { response in
            switch response.result {
                case .success:
                    response.value.map({value in
                        successCallback(value)
                    })
        
                case .failure(let error):
                    print(error)
                }
            }
    })
    
}

func getImage(successCallback: @escaping (ImageDetail) -> Void, id: String){
    let authRepository: AuthRepository = AuthRepository()
    let token: String? = authRepository.getToken();
    token.map({token in
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
        ]
        AF.request("http://195.39.233.28:8035/images/\(id)", method: .get, headers: headers).validate().responseDecodable(of: ImageDetail.self) { response in
            switch response.result {
                case .success:
                    response.value.map({value in
                        successCallback(value)
                    })
        
                case .failure(let error):
                    print(error)
                }
            }
    })
    
}
