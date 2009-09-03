require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe MixMaster do
  describe "mixing a module into a class" do
    before do
      @target = Class.new
      @source = Module.new do
        def something
        end
        
        def a_public_method
        end
        
      protected
      
        def a_protected_method
        end
        
      private
      
        def a_private_method
        end
      end
    end
    
    describe "mixing in" do
      it "should add a public method" do
        MixMaster.mixin(@source, @target)
      
        @target.new.should respond_to(:something)
      end
    
      it "should add private methods" do
        MixMaster.mixin(@source, @target)
      
        @target.new.private_methods.should include("a_private_method")
      end
    
      it "should add protected methods" do
        MixMaster.mixin(@source, @target)
      
        @target.new.protected_methods.should include("a_protected_method")
      end
    end
    
    describe "mixing out" do
      it "should no longer respond to a public method" do
        MixMaster.mixin(@source, @target)
        MixMaster.mixout(@source, @target)
      
        @target.new.should_not respond_to(:something)
      end
      
      it "should no longer respond to any public method" do
        MixMaster.mixin(@source, @target)
        MixMaster.mixout(@source, @target)
      
        @target.new.should_not respond_to(:a_public_method)
      end
      
      it "should no longer have protected methods added" do
        MixMaster.mixin(@source, @target)
        MixMaster.mixout(@source, @target)
      
        @target.new.protected_methods.should_not include("a_protected_method")
      end
      
      it "should no longer have private methods added" do
        MixMaster.mixin(@source, @target)
        MixMaster.mixout(@source, @target)
      
        @target.new.private_methods.should_not include("a_private_method")
      end
      
      it "should not remove the methods from the module given" do
        lambda {
          MixMaster.mixin(@source, @target)
          MixMaster.mixout(@source, @target)
        }.should_not change { @source.instance_methods }
      end
      
      it "should have a method added after remixing" do
        MixMaster.mixin(@source, @target)
        MixMaster.mixout(@source, @target)
        MixMaster.mixin(@source, @target)
        
        @target.new.should respond_to(:something)
      end
      
      it "should raise an error if never mixed in" do
        lambda {
          MixMaster.mixout(@source, @target)
        }.should raise_error(MixMaster::MixingError, "#{@source} was never mixed into #{@target} with \#mixin")
      end
      
      it "should be able to mixout from a first module after mixing to a second one" do
        one = Module.new do
          def one; end
        end
        
        two = Module.new do
          def two; end
        end
        
        MixMaster.mixin(one, @target)
        MixMaster.mixin(two, @target)
        MixMaster.mixout(one, @target)
        
        @target.new.should_not respond_to(:one)
        @target.new.should respond_to(:two)
      end
      
      it "should add methods in a module inside of a module" do
        one = Module.new do
          def one; end
        end
        
        two = Module.new do
          include one
        end
        
        MixMaster.mixin(two, @target)
        
        @target.new.should respond_to(:one)
      end
      
      it "should remove methods from other modules" do
        one = Module.new do
          def one; end
        end
        
        two = Module.new do
          include one
        end
        
        MixMaster.mixin(two, @target)
        MixMaster.mixout(two, @target)
        
        @target.new.should_not respond_to(:one)
      end
      
      it "should not remove methods like to_s which will be defined on a regular object & a module (since the class is always first in the hierarchy chain)" do
        one = Module.new do
        end
        
        MixMaster.mixin(one, @target)
        MixMaster.mixout(one, @target)
        
        @target.new.should respond_to(:inspect)
      end
      
      it "should allow calling of super in the hierarchy chain" do
        one = Module.new do
          def something
            "from_mod"
          end
        end
        
        two = Module.new do
          def something
            raise "got here"
            super
          end
        end
        
        klass = Class.new do
          def something
            super
          end
        end
        
        MixMaster.mixin(two, klass)
        MixMaster.mixin(one, klass)
        MixMaster.mixout(two, klass)
        
        klass.new.something.should == "from_mod"
      end
    end
  end
end