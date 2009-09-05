require "using"

module MixMaster
  extend Using
  
  using :Mixer
  using :MixinTable
  using :ModuleExtension
  using :Version
  
  class MixingError < StandardError; end
  extend Mixer
  
  class << self
    def install
      mixin MixMaster::ModuleExtension, Object
    end
  
    def uninstall
      mixout MixMaster::ModuleExtension, Object
    end
  end
end