require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe MixMaster do
  describe "installation" do
    after do
      MixMaster.uninstall
    end
    
    it "should have mixin + mixout in Object" do
      MixMaster.install
      Object.should respond_to(:mixin)
      Object.should respond_to(:mixout)
    end
  end
  
  describe "uninstall" do
    before do
      MixMaster.install
    end
    
    it "should uninstall mixin, mixout" do
      MixMaster.uninstall
    
      Object.should_not respond_to(:mixin)
      Object.should_not respond_to(:mixout)
    end
  end
end