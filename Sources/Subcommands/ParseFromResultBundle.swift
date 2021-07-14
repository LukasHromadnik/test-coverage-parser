import ArgumentParser

struct ParseFromResultBundle: ParsableCommand {
    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "bundle")
    }
    
    @Option(name: .long, help: "Path of .xcresult bundle file to be parsed")
    var resultBundlePath: String
    
    @Flag(help: "Set verbose output")
    var verbose = false
    
    func run() throws {
        try getCoverage(
            using: .resultBundle(path: resultBundlePath),
            verbose: verbose
        )
    }
}
