//
//  ParserError.swift
//  TestCoverageParser
//
//  Created by Lukáš Hromadník on 18.05.2021.
//

import Foundation

enum ParserError: Error {
    case decoding(DecodingError)
    case noBuildDir
    case noWorkspace
    case noTestResults(String)
    case unknown(Error)
}

extension ParserError: CustomStringConvertible {
    var description: String {
        switch self {
        case .decoding(let error): return error.localizedDescription
        case .noBuildDir: return "Missing Build directory in DerivedData"
        case .noWorkspace: return "No workspace can be found"
        case .noTestResults(let path): return "No XCResult bundle can be found at '" + path + "'"
        case .unknown(let error): return "Unknown error occured: " + error.localizedDescription
        }
    }
}
