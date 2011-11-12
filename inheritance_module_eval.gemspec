# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "inheritance_module_eval/version"

Gem::Specification.new do |s|
  s.name        = "inheritance_module_eval"
  s.version     = InheritanceModuleEval::VERSION
  s.authors     = ["Alexander Paramonov"]
  s.email       = ["alexander.n.paramonov@gmail.com"]
  s.homepage    = "http://github.com/AlexParamonov/inheritance_module_eval"
  s.summary     = %q{inheritance safe module_eval.}
  s.description = %q{saves inheritance structure of dynamically created methods.
Allows to redefine dynamic method in the same class or in any child class, and call original method by super keyword}

  s.rubyforge_project = "inheritance_module_eval"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", ">= 2.6"
  s.add_development_dependency "rake"
  # s.add_runtime_dependency "rest-client"
end
