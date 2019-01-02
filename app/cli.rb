#!/usr/bin/env ruby

require 'optparse'
require 'tty-table'

require_relative './controller.rb'

options = {}
OptionParser.new { |opts|
  opts.banner = 'usage: plug [options]'

  opts.on '-r', '--roll', 'roll a joint' do |r|
    options[:roll] = r
  end

  opts.on '-s', '--smoke', 'smoke a joint' do |s|
    options[:smoke] = s
  end

  opts.on '-S STRAIN', '--strain=STRAIN', 'a strain' do |s|
    options[:strain] = s
  end

  opts.on '-q QUANTITY', '--quantity=QUANTITY', 'a quantity' do |q|
    begin
      options[:quantity] = Integer(q)
    rescue ArgumentError
      options[:quantity] = 1
    end
  end

  opts.on '-i', '--inventory', 'take inventory' do |i|
    options[:inventory] = i
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
}.parse!

controller = Controller.new
if options[:inventory]
  data = controller.hunt.values
    .select { |i| i[:quantity] > 0 }
    .sort { |a, b| b[:quantity] <=> a[:quantity] }
    .map { |r| [r[:strain], r[:quantity]] }

  table = TTY::Table.new header: ['strain', 'quantity'], rows: data
  puts table.render(:unicode)
elsif options[:roll]
  number = Integer(number) rescue ArgumentError
  controller.roll options[:strain], options[:quantity]
elsif options[:smoke]
  controller.smoke options[:strain], options[:quantity]
end
