#!/usr/bin/env ruby

require 'optparse'
require 'tty-table'

require_relative './controller.rb'

options = {}
OptionParser.new { |opts|
  opts.banner = 'usage: plug [options]'

  opts.on '-r', '--roll' do |r|
    options[:roll] = r
  end

  opts.on '-s', '--smoke' do |s|
    options[:smoke] = s
  end
}.parse!

controller = Controller.new
if(options[:roll])
  strain, family, number = ARGV

  begin
    number = Integer(number)
  rescue ArgumentError
    puts 'usage:'
    puts '  plug [-r, --roll] strain (sativa|indica|hybrid) quantity'
    exit!
  end

  controller.roll strain, family, number
elsif options[:smoke]
  strain = ARGV[0]
  controller.smoke strain
else
  data = controller.hunt.values.map {|r| [r[:strain], r[:family], r[:quantity]]}
  table = TTY::Table.new header: ['strain', 'family', 'quantity'], rows: data
  puts table.render(:unicode)
end
