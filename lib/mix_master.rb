require File.expand_path(File.dirname(__FILE__) + "/mix_master/mixer")
require File.expand_path(File.dirname(__FILE__) + "/mix_master/mixin_table")
require File.expand_path(File.dirname(__FILE__) + "/mix_master/module_extension")

module MixMaster
  class MixingError < StandardError; end
  extend Mixer
end

class Module
  include MixMaster::ModuleExtension
end