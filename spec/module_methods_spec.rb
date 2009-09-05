require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "module extensions" do
  before do
    MixMaster.install
  end
  
  after do
    MixMaster.uninstall
  end
  
  it "should be able to mixin to a class with mixin" do
    a_mod = Module.new do
      def foo; end
    end
    
    klass = Class.new do
      mixin a_mod
    end
    
    klass.new.should respond_to(:foo)
  end
  
  it "should be able to mixout a class" do
    a_mod = Module.new do
      def foo; end
    end
    
    klass = Class.new do
      mixin a_mod
      mixout a_mod
    end
    
    klass.new.should_not respond_to(:foo)
  end
  
  it "should be able to mixin several modules with one call" do
    one = Module.new do
      def one; end
    end
    
    two = Module.new do
      def two; end
    end
    
    klass = Class.new do
      mixin one, two
    end
    
    klass.new.should respond_to(:one)
    klass.new.should respond_to(:two)
  end
  
  it "should be able to mixout several modules at once" do
    one = Module.new do
      def one; end
    end
    
    two = Module.new do
      def two; end
    end
    
    klass = Class.new do
      mixin one
      mixin two
      
      mixout one, two
    end
    
    klass.new.should_not respond_to(:one)
    klass.new.should_not respond_to(:two)
  end
  
  it "should have mixin as a public interface" do
    Class.new.should respond_to(:mixin)
  end
  
  it "should have mixout as a public interface" do
    Class.new.should respond_to(:mixout)
  end
end