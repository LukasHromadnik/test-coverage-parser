//
//  script.swift
//  TestCoverageParser
//
//  Created by Lukáš Hromadník on 18.05.2021.
//

import Foundation

func defaultWorkspace() -> String? {
    try? FileManager.default
        .contentsOfDirectory(
            at: URL(fileURLWithPath: FileManager.default.currentDirectoryPath),
            includingPropertiesForKeys: nil
        )
        .filter { $0.lastPathComponent.hasSuffix("xcworkspace") }
        .first
        .map { $0.deletingPathExtension().lastPathComponent }
}

func getBuildSettings(workspace: String?, scheme: String, verbose: Bool) throws -> BuildSettings {
    guard let workspace = workspace ?? defaultWorkspace()
    else { throw ParserError.noWorkspace }
    
    let buildSettingsJSON = shell(
        "xcodebuild -workspace \(workspace).xcworkspace -scheme \(scheme) -showBuildSettings -json 2>/dev/null",
        verbose: verbose
    )
    
    let data = Data(buildSettingsJSON.utf8)
    do {
        let decoded = try JSONDecoder().decode([BuildSettingsResult].self, from: data)
        return decoded.first?.buildSettings ?? [:]
    } catch let error as DecodingError {
        throw ParserError.decoding(error)
    } catch {
        throw ParserError.unknown(error)
    }
}

func getTestResult(using buildSettings: BuildSettings, verbose: Bool) throws -> TestResult {
    guard let buildDirPath = buildSettings["BUILD_DIR"]
    else { throw ParserError.noBuildDir }
    
    let buildDir = URL(fileURLWithPath: buildDirPath)
    let testDir = buildDir
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent("Logs")
        .appendingPathComponent("Test")

    let testContents = (try? FileManager.default.contentsOfDirectory(at: testDir, includingPropertiesForKeys: nil)) ?? []
    
    guard let testResult = testContents.filter({ $0.absoluteString.contains("xcresult") }).first
    else { throw ParserError.noTestResults }
    
    let testResultJSON = shell(
        "xcrun xccov view --report --json \(testResult.path) 2>/dev/null",
        verbose: verbose
    )
    let data = Data(testResultJSON.utf8)
    
    do {
        return try JSONDecoder().decode(TestResult.self, from: data)
    } catch let error as DecodingError {
        throw ParserError.decoding(error)
    } catch {
        throw ParserError.unknown(error)
    }
}
