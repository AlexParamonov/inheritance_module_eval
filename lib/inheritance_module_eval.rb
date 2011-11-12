require "inheritance_module_eval/version"

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

module InheritanceModuleEval
  def self.instance_eval_on(sender, code, &block)
    sender.send :include, (get_module_for code, &block)
  end

  def self.class_eval_on(sender, code, &block)
    sender.send :extend, (get_module_for code, &block)
  end

  private
  def self.get_module_for(code, &block)
    raise ArgumentError, "Empty code given" if (code.nil? or code.empty?) and not block_given?
    include_module = Module.new
    if code.nil? then include_module.module_eval &block else include_module.module_eval code end

    include_module
  end
end
