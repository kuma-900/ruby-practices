# frozen_string_literal: true

require 'optparse'

class LsOptions
  def initialize(argv)
    @options = {}
    opt = OptionParser.new

    opt.on('-a') { @options[:show_hidden] = true }
    opt.on('-r') { @options[:reverse] = true }
    opt.on('-l') { @options[:long_format] = true }

    opt.parse!(argv)
  end

  def show_hidden?
    @options[:show_hidden]
  end

  def reverse?
    @options[:reverse]
  end

  def long_format?
    @options[:long_format]
  end
end
