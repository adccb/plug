require 'tty-table'

require_relative './recorder.rb'

class Controller
  def initialize options
    @records = Recorder.new

    if options[:inventory]
      puts format
    elsif options[:roll]
      @records.add_joint options[:strain].to_sym, options[:quantity]
    elsif options[:smoke]
      @records.remove_joint options[:strain].to_sym, options[:quantity]
    end
  end

  private
  def format
    data = @records.record.values
      .select { |i| i[:quantity] > 0 }
      .sort { |a, b| b[:quantity] <=> a[:quantity] }
      .map { |r| [r[:strain], r[:quantity]] }

    table = TTY::Table.new header: ['strain', 'quantity'], rows: data
    table.render(:unicode)
  end
end
