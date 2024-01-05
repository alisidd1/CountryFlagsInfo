//
//  Errors.swift
//  CountryFlagsInfo
//
//  Created by Ali Siddiqui on 11/29/23.
//

import UIKit

enum CustomError: String, Error {
    case invalidUrl =  "Invalid URL to get countries' info" 
    case unableToComplete =  "Unable to complete the request. Please check your network connection"
    case invalidResponse = "Invalid response from the server. Please try again later."
    case invalidData = "The data received from the server was invalid. Please try again later"
}
