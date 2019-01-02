require_relative './recorder.rb'

class Controller
  def initialize
    @records = Recorder.new
  end

  def roll strain, number
    number.times { @records.add_joint(strain.to_sym) }
  end

  def smoke strain, number
    number.times { @records.remove_joint(strain.to_sym) }
  end
  
  def hunt
    @records.record
  end
end
