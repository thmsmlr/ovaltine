require "optparse"
require "ovaltine/decoder"
require "ovaltine/check"

# Load all decoders and checks
Dir[File.dirname(__FILE__) + "/decoders/*.rb"].each {|file| require file }
Dir[File.dirname(__FILE__) + "/checks/*.rb"].each {|file| require file }

class Ovaltine::CLI

  def self.start(*args)
    options = {}

    # Build argument parser
    opt_parser = OptionParser.new do |opt|
      opt.banner = "Usage: ovaltine [options] FILE"
      opt.on("-i", "--ignore-checks", "Ignore all checks") do
        options[:ignore_checks] = true
      end

      opt.on("-d", "--depth", "Deepest permutation length") do |depth|
        options[:depth] = depth
      end

      opt.on("-h", "--help", "Help") do
        puts opt_parser
        exit 1
      end

      # Add the check arguments
      options[:black_list] = []
      Ovaltine::Check.all_checks.each do |check|
        check.add_arguments(opt) if check.methods(false).include? :add_arguments
        opt.on("--no-#{check.name.split("::")[-1].downcase}") do
          options[:black_list] << check
        end
      end

    end

    opt_parser.parse!(args)

    # Get the decoded string
    if args.length == 0 && ! $stdin.tty?
      encoded_str = $stdin.read
    elsif args.length == 1
      encoded_str = File.read(args[0])
    else
      puts opt_parser
      exit 1
    end

    # Load all the appropriate decoders and checks
    decoders = Ovaltine::Decoder.all_decoders
    options[:depth] ||= 2
    if options[:ignore_checks]
      checks = []
    else
      checks = Ovaltine::Check.all_checks(:black_list => options[:black_list])
    end

    Ovaltine::Decoder.find_encoding(encoded_str, decoders,
                                    checks, options[:depth]).each { |chain|
      puts chain.name
      puts chain.decode(encoded_str)
      puts
    }
  end
end
