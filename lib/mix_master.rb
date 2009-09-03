require "using"

module MixMaster
  extend Using
  
  using :Mixer
  using :MixinTable
  using :ModuleExtension
  using :Version
  
  VERSION = Version::STRING
  
  class MixingError < StandardError; end
  extend Mixer
end

class Module
  include MixMaster::ModuleExtension
end