//
//  Helpers.swift
//  TestCoverageParser
//
//  Created by Lukáš Hromadník on 18.05.2021.
//

import Foundation

/// Runs given shell `command` and returns its output
///
/// - Parameters
///   - `command`: Given command to run
///   - `verbose`: Show verbose output
/// - Returns: Output of the given command
func shell(_ command: String, verbose: Bool) -> String {
    if verbose {
        print("[SHELL] Running `\(command)`")
    }
    
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    if verbose {
        print("[OUTPUT]", output)
    }
    
    return output
}

enum Arguments {
    case project(scheme: String, workspace: String?)
    case resultBundle(path: String)
}
