require "using"

module MixMaster
  extend Using
  
  using :Mixer
  using :MixinTable
  using :ModuleExtension
  
  class MixingError < StandardError; end
  extend Mixer
end

class Module
  include MixMaster::ModuleExtension
end