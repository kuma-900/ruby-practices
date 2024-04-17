#!/usr/bin/env ruby

require 'optparse'
require 'date'

options = {}

opt = OptionParser.new

opt.on("-y YEAR", Integer){|input_year| options[:year] = input_year}
opt.on("-m MONTH", Integer){|input_month| options[:month] = input_month}

opt.parse!

year = options[:year] || Date.today.year
month = options[:month] || Date.today.month

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
today = Date.today

puts first_day.strftime("%-m月 %Y").center(20)
puts "日 月 火 水 木 金 土"

print "   " * first_day.wday
(first_day..last_day).each do |date|
  if date == today
    print "\e[7m#{date.day.to_s.rjust(2)}\e[0m " 
  else
  print date.day.to_s.rjust(2) + " "
  end
  if date.saturday?
    puts
  end
end
