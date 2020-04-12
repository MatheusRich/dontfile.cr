module Dontfile::Command
  def self.run(args = ARGV)
    command = args.first? || ""

    return puts "No command given" if command.empty?

    args.shift

    case command.downcase
    when "read"
      Dontfile::Command::ReadPage.run(args)
    when "write"
      Dontfile::Command::WritePage.run(args)
    else
      puts "Unknown command"
    end
  end
end
