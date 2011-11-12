require "inheritance_module_eval"

class Parent

end

class Child < Parent

end
describe InheritanceModuleEval do
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

  describe "add dynamic methods" do
    before(:each) do
      @test_object = Class.new
    end

    pending "should delegate to module_eval" do
      Module.should_receive(:module_eval).twice
      @test_object.instance_module_eval %{
        def say_hi
          puts hi
        end
      }
      @test_object.class_module_eval %{
        def say_hi
          puts hi
        end
      }
    end

    describe "instance methods" do
      it "should eval a string" do
        @test_object.instance_module_eval %{
          def say_hi
            puts 'hi'
          end
                                              }
          @test_object.new.should respond_to :say_hi

      end
      it "should eval a block" do
        @test_object.instance_module_eval do
          def say_hi
            puts 'hi'
          end
        end
        @test_object.new.should respond_to :say_hi
      end
    end

    describe "class_methods" do
      it "should eval a string" do
        @test_object.class_module_eval %{
          def say_hi
            puts 'hi'
          end
                                              }
          @test_object.should respond_to :say_hi

      end
      it "should eval a block" do
        @test_object.class_module_eval do
          def say_hi
            puts 'hi'
          end
        end
        @test_object.should respond_to :say_hi
      end
    end


    describe "collisions" do
      describe "define already defined method in a class" do
        describe "redefine it after class declaration" do
          it "should has lower priority then method, declared in a class" do
            klass = Class.new
            klass.class_eval do
              def say_hi
                "hi from method" << " " << super
              end
              instance_module_eval %{
                def say_hi
                  "hi from eval"
                end
              }
            end
            klass.new.say_hi.should == "hi from method hi from eval"
          end
        end

        describe "redefine it before class declaration" do
          it "should push dynamic method up in the inheritance tree" do
            klass = Class.new
            klass.class_eval do
              instance_module_eval %{
                def say_hi
                  "tiny hi"
                end
              }
              def say_hi
                super.upcase
              end
            end
            klass.new.say_hi.should == "TINY HI"
          end
        end

        describe "redefine as much as you want" do
          it "should push dynamic method up in the inheritance tree" do
            klass = Class.new
            klass.class_eval do
              instance_module_eval %{
                def say_hi
                  [5]
                end
              }
              instance_module_eval %{
                def say_hi
                  [4] + super
                end
              }
              instance_module_eval %{
                def say_hi
                  [3] + super
                end
              }
              instance_module_eval %{
                def say_hi
                  [2] + super
                end
              }
              def say_hi
                [1] + super
              end
            end
            klass.new.say_hi.should == [1, 2, 3, 4, 5]
          end
        end

        describe "redefine it inside a module" do
          it "should push dynamic method before module and after class declaration" do
            test_module = Module.new
            test_module.module_eval do
              def say_hi
                ["hi from module"]
              end
            end

            klass = Class.new
            klass.class_eval do
              include test_module
              instance_module_eval do
                def say_hi
                  ["hi from eval"] + super
                end
              end

              def say_hi
                ["hi from method"] + super
              end
            end
            klass.new.say_hi.should == ["hi from method", "hi from eval", "hi from module"]
          end
        end
      end
    end


    describe "#get_module_for" do
      it "should return Module" do
        InheritanceModuleEval.send :get_module_for, "puts('hi')"
      end

      it "should raise ArgumentError if no code given" do
        ["", nil, []].each do |empty|
          expect{InheritanceModuleEval.send :get_module_for, empty}.to raise_error ArgumentError
        end
      end
    end

  end
end
