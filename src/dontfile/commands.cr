module Dontfile::Command
  USAGE = <<-USAGE
   Usage: dontfile [command] [options]

   Command:
       read                     outputs the content of a page
       write                    writes on a page
       help, --help, -h         shows this help
       version, --version, -v   shows version

   Run a command followed by --help to see command specific information. Ex:
       dontfile <command> --help
   USAGE

  def self.run(args = ARGV)
    command = args.first? || ""

    return puts "No command given" if command.empty?

    case command.downcase
    when "read", "r"
      args.shift
      Dontfile::Command::ReadPage.run(args)
    when "write", "w"
      args.shift
      Dontfile::Command::WritePage.run(args)
    when "-v", "--version", "version"
      puts Dontfile::VERSION
    when "-h", "--help", "help"
      puts USAGE
    else
      Dontfile::Command::ReadPage.run(args)
    end
  end
end
