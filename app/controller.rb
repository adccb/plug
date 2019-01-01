require_relative './recorder.rb'

class Controller
  def initialize
    @records = Recorder.new
  end

  def roll strain, family, number
    number.times { @records.add_joint(strain.to_sym, family) }
  end

  def smoke strain
    @records.remove_joint(strain.to_sym)
  end
  
  def hunt
    @records.take_inventory
  end
end
