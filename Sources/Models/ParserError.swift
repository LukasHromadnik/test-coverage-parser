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
    case noTestResults
    case unknown(Error)
}
