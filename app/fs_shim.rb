require 'json'

class Shim
  def initialize
    @dir = "#{Dir.home}/.plug"
    @file = "#{@dir}/manifest.json"
    Dir.mkdir @dir if not File.exist? @dir
    if not File.exist? @file
      f = File.open @file, 'w'
      f.write '{}'
    end
  end

  def read
    JSON.parse File.read(@file), :symbolize_names => true
  end
  
  def write! json
    File.open @file, 'w' do |f| f.write JSON.generate(json) end
  end
end
