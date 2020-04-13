module Dontfile::Command
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
    else
      Dontfile::Command::ReadPage.run(args)
    end
  end
end
