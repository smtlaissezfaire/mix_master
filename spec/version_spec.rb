require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

module MixMaster
  describe VERSION do
    it "should be at VERSION 0.0.1" do
      MixMaster::VERSION.should == "0.0.1"
    end
  end
end