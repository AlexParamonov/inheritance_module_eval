require "integration_module_eval"
class Module
  # acts same as module_eval, but saves method hierarchy
  # should be called only for instance methods evaluation
  # @params (see Module#module_eval)
  def instance_module_eval(code = nil, &block)
    InheritanceModuleEval.instance_eval_on self, code, &block
  end

  # acts same as module_eval, but saves method hierarchy
  # should be called only for class methods evaluation
  # @params (see Module#module_eval)
  def class_module_eval(code = nil, &block)
    InheritanceModuleEval.class_eval_on self, code, &block
  end
end