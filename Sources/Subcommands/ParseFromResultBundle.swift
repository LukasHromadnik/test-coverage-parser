import ArgumentParser

struct ParseFromResultBundle: ParsableCommand {
    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "bundle")
    }
    
    @Option(name: .long, help: "")
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
