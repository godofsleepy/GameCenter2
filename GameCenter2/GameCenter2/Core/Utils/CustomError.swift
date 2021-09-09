//
//  CustomError.swift
//  GameCenter2
//
//  Created by rifat khadafy on 06/12/20.
//

import Foundation

enum URLError: LocalizedError {

  case invalidResponse
  case addressUnreachable
  
  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable: return "Data is unreachable."
    }
  }

}

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }

}

