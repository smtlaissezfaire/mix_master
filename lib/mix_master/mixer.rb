module MixMaster
  module Mixer
    def mixin(mod, target)
      mod_duplicate = mod.clone
      
      target.instance_eval { include mod_duplicate }
      
      mixin_table.set(mod, target, mod_duplicate)
    end
  
    def mixout(from, to)
      check_mixin(from, to)
      
      mixin_table.get(from, to).instance_eval do
        methods = (public_instance_methods(false) + protected_instance_methods(false) + private_instance_methods(false))
        
        methods.each do |m|
          remove_method m
        end
      end
      
      mixin_table.delete(from, to)
    end
    
  private
  
    def check_mixin(from, to)
      unless mixin_table.exists?(from, to)
        raise MixMaster::MixingError, "#{from} was never mixed into #{to} with #mixin, or was already mixed out"
      end
    end
  
    def mixin_table
      @mixin_table ||= MixinTable.new
    end
  end
end