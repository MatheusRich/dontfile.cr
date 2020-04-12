module Dontfile::Command
  def self.run(args = ARGV)
    command = args.first? || ""

    return puts "No command given" if command.empty?

    args.shift

    case command.downcase
    when "read", "r"
      Dontfile::Command::ReadPage.run(args)
    when "write", "w"
      Dontfile::Command::WritePage.run(args)
    when "-v", "--version", "version"
      puts Dontfile::VERSION
    else
      puts "Unknown command"
    end
  end
end
