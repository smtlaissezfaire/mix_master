module MixMaster
  module ModuleExtension
    def mixin(*mods)
      mods.each do |mod|
        MixMaster.mixin(mod, self)
      end
    end

    def mixout(*mods)
      mods.each do |mod|
        MixMaster.mixout(mod, self)
      end
    end
  end
end