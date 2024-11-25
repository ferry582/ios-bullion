//
//  APIErrorResponse.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import Foundation

struct APIErrorResponse: Codable, Error {
    let errCode: String
    let errMessage: String
    let errMessageEn: String
    
    private enum CodingKeys: String, CodingKey {
      case errCode = "err_code"
      case errMessage = "err_message"
      case errMessageEn = "err_message_en"
    }
}
