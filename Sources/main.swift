//
//  main.swift
//  TestCoverageParser
//
//  Created by Lukáš Hromadník on 18.05.2021.
//

import ArgumentParser

struct TestCoverageParser: ParsableCommand {
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            subcommands: [
                ParseFromProject.self,
                ParseFromResultBundle.self
            ],
            defaultSubcommand: ParseFromProject.self
        )
    }
}

TestCoverageParser.main()
