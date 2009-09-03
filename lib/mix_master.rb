class MixMaster
  class MixingError < StandardError; end
  
  module Mixer
    def mixin(mod, target)
      mod_duplicate = mod.clone
      
      target.instance_eval { include mod_duplicate }
      
      mixin_list.set(mod, target, mod_duplicate)
    end
  
    def mixout(from, to)
      check_mixin(from, to)
      
      mixin_list.get(from, to).instance_eval do
        methods = (public_instance_methods + protected_instance_methods + private_instance_methods)
        
        methods.each do |m|
          undef_method m
        end
      end
    end
    
  private
  
    def check_mixin(from, to)
      unless mixin_list.exists?(from, to)
        raise MixMaster::MixingError, "#{from} was never mixed into #{to} with \#mixin"
      end
    end
  
    def mixin_list
      @mixin_list ||= MixinTable.new
    end
  end
  
  extend Mixer
  
  class MixinTable
    def initialize
      @list = {}
    end
    
    def set(source, target, source_dup)
      @list[source] ||= {}
      @list[source][target] = source_dup
    end
    
    def exists?(from, to)
      get(from, to) ? true : false
    end
    
    def get(from, to)
      @list[from] && @list[from][to]
    end
  end
end