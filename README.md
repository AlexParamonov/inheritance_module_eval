Inheritance module_eval
=======================
Inheritance module_eval saves inheritance structure of dynamically created methods.
Allows to redefine dynamic method in the same class or in any child class, and call original method by super keyword

Installation
------------
    gem inheritance_module_eval

Usage
-----
There are 2 methods:

* instance_module_eval
* class_module_eval

instance_module_eval method used to eval instance methods (ie: methods of an object)

class_module_eval method used to eval class methods (ie: methods of an class)


Below is some simple example of inheritance_module_eval usage:

    require 'inheritance_module_eval'

    # Some dummy class that uses #instance_module_eval
    class Content
      self.field(name)
        instance_module_eval %{
          def #{name}
            instance_valiable_get(@#{name})
          end

          def #{name}=(new_value)
            instance_valiable_set(@#{name}, new_value)
          end
        }
        end
      end
    end


    class Article < Content
      field :title
      field :content
      field :etc

      # you can use inheritance!
      # you dont need to call alias_method anymore!
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

* 1.8.7 # (current default)
* 1.9.2
* 1.9.3
* jruby
* ruby-head
* ree

see [build history](http://travis-ci.org/#!/AlexParamonov/inheritance_module_eval/builds)

Copyright
---------
Copyright © 2011 Alexander N Paramonov. See LICENSE for details.