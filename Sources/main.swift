//
//  main.swift
//  TestCoverageParser
//
//  Created by Lukáš Hromadník on 18.05.2021.
//

import ArgumentParser

struct TestCoverageParser: ParsableCommand {
    @Option(name: .long, help: "Name of the scheme")
    var scheme: String?

    @Option(name: .long, help: "Name of the workspace")
    var workspace: String?
    
    @Option(name: .long, help: "")
    var resultBundlePath: String?
        
    @Flag(help: "Set verbose output")
    var verbose = false
    
    func run() throws {
        let result: TestResult = try {
            if let resultBundlePath = resultBundlePath {
                return try getTestResult(from: resultBundlePath, verbose: verbose)
            } else if let scheme = scheme {
                let buildSettings = try getBuildSettings(workspace: workspace, scheme: scheme, verbose: verbose)
                return try getTestResult(using: buildSettings, verbose: verbose)
            } else {
                throw ValidationError("One of arguments `--scheme` or `--result-bundle-path` is required")
            }
        }()
        
        print(result.lineCoverage)
    }
}

TestCoverageParser.main()
