require 'json'

require_relative 'fs_shim.rb'

class Recorder
  attr_accessor :record
  def initialize
    @shim = Shim.new
    @record = @shim.read 
  end

  def add_joint strain, number
    record = @record[strain]
    if record.nil?
      @record[strain] = { :strain => strain, :quantity => number }
    else
      record[:quantity] += number
    end

    @shim.write! @record
  end

  def remove_joint strain, number
    record = @record[strain]
    if record.nil?
      puts "looks like we don\'t have anything for #{strain}. did you mistype?"; exit!
    else
      record[:quantity] -= number
    end
    @shim.write! @record
  end
end
