//
//  Enum,.swift
//  GitHubFollowerBymyselfProject
//
//  Created by 김윤석 on 2022/03/16.
//

import Foundation

public enum GFError: String, Error {
    case error = "ERROR"
    case sameDataAlreadyExist = "same data already exist"
    case netWorkFetchingError = "Could not fetch data from server"
    case userDefaultFetchingError = "Could not fetch local data"
    case wrongUrl = "wrong URL! Please check your URL again"
    case failedToDecodeData = "failed to decode data"
    case cannotDecode = "Wrong data format. Failed to decode."
}
