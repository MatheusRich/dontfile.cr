module Dontfile::Command
  def self.run(args = ARGV)
    command = args.first? || ""

    return puts "No command given" if command.empty?

    args.shift

    case command.downcase
    when "read"
      Dontfile::Command::ReadPage.run(args)
    when "write"
    else
      puts "Unknown command"
    end
  end
end
