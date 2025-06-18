#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'entry_list'
require_relative 'ls_options'
require_relative 'ls_formatter'

options = LsOptions.new(ARGV)

entry_list = EntryList.new(Dir.entries('.'))
entry_list = entry_list.remove_hidden unless options.show_hidden?
entry_list = entry_list.sort_by_name
entry_list = entry_list.reverse if options.reverse?

formatter = LsFormatter.new(entry_list, options)
puts formatter.format
