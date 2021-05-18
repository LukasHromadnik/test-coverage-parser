//
//  main.swift
//  TestCoverageParser
//
//  Created by Lukáš Hromadník on 18.05.2021.
//

import ArgumentParser

struct TestCoverageParser: ParsableCommand {
    @Option(name: .long, help: "Name of the workspace")
    var workspace: String
    
    @Option(name: .long, help: "Name of the scheme")
    var scheme: String
    
    @Flag(help: "Set verbose output")
    var verbose = false
    
    func run() throws {
        let buildSettings = try getBuildSettings(workspace: workspace, scheme: scheme, verbose: verbose)
        let result = try getTestResult(using: buildSettings, verbose: verbose)
        print(result.lineCoverage)
    }
}

TestCoverageParser.main()
