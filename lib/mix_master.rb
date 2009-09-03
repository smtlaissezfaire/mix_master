require File.expand_path(File.dirname(__FILE__) + "/mix_master/mixer")
require File.expand_path(File.dirname(__FILE__) + "/mix_master/mixin_table")

class MixMaster
  class MixingError < StandardError; end
  extend Mixer
end