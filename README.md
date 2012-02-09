Inheritance module_eval
=======================
[![Build Status](https://secure.travis-ci.org/AlexParamonov/inheritance_module_eval.png)](http://travis-ci.org/AlexParamonov/inheritance_module_eval)
[![Gemnasium Build Status](https://gemnasium.com/AlexParamonov/inheritance_module_eval.png)](http://gemnasium.com/AlexParamonov/inheritance_module_eval)  

Allows to create methods with same name inside particular class/object by pushing them down by inheritance tree.  
So method "field" may call other "field" in same class by calling super keyword instead of just redefine it.

Installation
------------
    gem install inheritance_module_eval

Usage
-----
Inheritance module_eval provides 2 methods for eval instance and class methods:

* instance_eval_on
* class_eval_on


    InheritanceModuleEval.instance_eval_on(instance_object, code = nil, &block) #method used to eval instance methods (ie: methods of an object)
    InheritanceModuleEval.class_eval_on(class_object, code = nil, &block)       #method used to eval class methods (ie: methods of an class)

Note: you may include

    require "inheritance_module_eval/integration"
to intergate inheritance_module_eval in ruby core. That will give 2 methods:

* instance_module_eval(code = nil, &block)
* class_module_eval(code = nil, &block)

Below is some simple example of inheritance_module_eval usage:

    require 'inheritance_module_eval'
    require "inheritance_module_eval/integration"

    # Some dummy class that uses #instance_module_eval
    class Content
      # defines simple getter and setter
      self.field(name)
        instance_module_eval %{
          def #{name}
            @#{name}
          end

          def #{name}=(new_value)
            @#{name}= new_value
          end
        }
        end
      end
    end


    class Article < Content
      field :title
      field :content
      field :etc

      # you desided, that title for article should be titelized
      # from now you dont need to call alias_method or reimplement method anymore!
      # you can use inheritance!
      # make it simple
      def title
        super.to_s.titelize
      end
    end

Requirements
------------
none

rspec2 for testing

Compatibility
-------------
tested with Ruby

* 1.8.7
* 1.9.2
* 1.9.3
* jruby-19mode
* jruby-18mode
* rbx-19mode
* rbx-18mode
* ruby-head
* ree

see [build history](http://travis-ci.org/#!/AlexParamonov/inheritance_module_eval/builds)

Contributing
-------------
see [contributing guide](http://github.com/AlexParamonov/inheritance_module_eval/blob/master/CONTRIBUTING.md)

Copyright
---------
Copyright © 2011-2012 Alexander N Paramonov.
Released under the MIT License. See the LICENSE file for further details.