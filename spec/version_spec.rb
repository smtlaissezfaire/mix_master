require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

module MixMaster
  describe VERSION do
    it "should be at VERSION 0.0.2" do
      MixMaster::Version::STRING.should == "0.0.2"
    end
  end
end