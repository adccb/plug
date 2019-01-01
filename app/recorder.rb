require 'json'

class Recorder
  def initialize
    _create_storage_if_not_exists!
    @record = JSON.parse File.read(@file), :symbolize_names => true
  end

  def take_inventory
    @record
  end

  def add_joint strain, family
    record = @record[strain]
    puts record

    if not record.nil?
      record[:quantity] += 1
    else
      @record[strain] = { :strain => strain, :family => family, :quantity => 1 }
    end
  
    write! JSON.generate(@record)
  end

  def remove_joint strain
    if not @record[strain]
      puts "looks like we don\'t have anything for #{strain}. did you mistype?"
      exit!
    end

    @record[strain][:quantity] -= 1

    write! JSON.generate(@record)
  end

  private
  def _create_storage_if_not_exists!
    @dir = "#{Dir.home}/.plug"
    @file = "#{@dir}/manifest.json"

    Dir.mkdir @dir if not File.exist? @dir

    if not File.exist? @file
      f = File.open @file, 'w'
      f.write '{}'
    end
  end

  def write! json
    File.open @file, 'w' do |f| f.write json end
  end
end
