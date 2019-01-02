#!/usr/bin/env ruby

require 'optparse'

require_relative './controller.rb'

options = {}
OptionParser.new { |opts|
  opts.banner = 'usage: plug [options]'
  opts.on("-h", "--help", "Prints this help") do puts opts; exit! end
  opts.on '-i', '--inventory', 'take inventory' do |i| options[:inventory] = i end
  opts.on '-r', '--roll', 'roll a joint' do |r| options[:roll] = r end
  opts.on '-s', '--smoke', 'smoke a joint' do |s| options[:smoke] = s end
  opts.on '-S STRAIN', '--strain=STRAIN', 'a strain' do |s| options[:strain] = s end
  opts.on '-q QUANTITY', '--quantity=QUANTITY', 'a quantity' do |q|
    begin
      options[:quantity] = Integer(q)
    rescue ArgumentError
      options[:quantity] = 1
    end
  end
}.parse!

controller = Controller.new options
