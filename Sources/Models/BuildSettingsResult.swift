//
//  BuildSettingsResult.swift
//  TestCoverageParser
//
//  Created by Lukáš Hromadník on 18.05.2021.
//

import Foundation

typealias BuildSettings = [String: String]

struct BuildSettingsResult: Codable {
    let buildSettings: BuildSettings
}
