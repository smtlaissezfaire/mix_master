module MixMaster
  module Version
    STRING = File.read(File.expand_path(File.dirname(__FILE__) + "/../../VERSION")).strip
    
    MAJOR,
    MINOR,
    TINY   = STRING.split(",")
  end
end