require "inheritance_module_eval/version"

module InheritanceModuleEval
  def self.instance_eval_on(sender, code = nil, &block)
    sender.send :include, (get_module_for code, &block)
  end

  def self.class_eval_on(sender, code = nil, &block)
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
