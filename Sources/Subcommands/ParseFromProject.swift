import ArgumentParser

struct ParseFromProject: ParsableCommand {
    static var configuration: CommandConfiguration {
        CommandConfiguration(commandName: "project")
    }
    
    @Option(name: .long, help: "Name of the scheme")
    var scheme: String

    @Option(name: .long, help: "Name of the workspace")
    var workspace: String?
    
    @Flag(help: "Set verbose output")
    var verbose = false
    
    private var arguments: Arguments {
        .project(scheme: scheme, workspace: workspace)
    }
    
    func run() throws {
        try getCoverage(using: arguments, verbose: verbose)
    }
}
