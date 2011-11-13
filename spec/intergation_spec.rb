require "inheritance_module_eval/integration"
describe "integration" do
  specify "class should respond to instance_module_eval" do
    Class.new.should respond_to(:instance_module_eval)
  end

  specify "module should respond to instance_module_eval" do
    Module.new.should respond_to(:instance_module_eval)
  end

  specify "class should respond to class_module_eval" do
    Class.new.should respond_to(:class_module_eval)
  end

  specify "module should respond to class_module_eval" do
    Module.new.should respond_to(:class_module_eval)
  end
end