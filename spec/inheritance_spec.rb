require "inheritance_module_eval"

class Parent

end

class Child < Parent

end
describe InheritanceModuleEval do
  describe "add dynamic methods" do
    before(:each) do
      @test_object = Class.new
    end

    it "should delegate to module_eval" do
      mock_module = mock(:mock_module)
      @test_object.stub(:include)
      @test_object.stub(:extend)
      Module.stub(:new).and_return(mock_module)

      mock_module.should_receive(:module_eval).once

      InheritanceModuleEval.instance_eval_on @test_object do
        def say_hi
          puts hi
        end
      end

      mock_module.should_receive(:module_eval).once

      InheritanceModuleEval.class_eval_on @test_object do
        def say_hi
          puts hi
        end
      end
    end

    describe "instance methods" do
      it "should eval a string" do
        InheritanceModuleEval.instance_eval_on @test_object, %{
                                                                def say_hi
                                                                  puts 'hi'
                                                                end
                                                              }
          @test_object.new.should respond_to :say_hi

      end
      it "should eval a block" do
        InheritanceModuleEval.instance_eval_on @test_object do
          def say_hi
            puts 'hi'
          end
        end
        @test_object.new.should respond_to :say_hi
      end
    end

    describe "class_methods" do
      it "should eval a string" do
        InheritanceModuleEval.class_eval_on @test_object do
          def say_hi
            puts 'hi'
          end
        end

        @test_object.should respond_to :say_hi
      end
      it "should eval a block" do
        InheritanceModuleEval.class_eval_on @test_object do
          def say_hi
            puts 'hi'
          end
        end

        @test_object.should respond_to :say_hi
      end
    end


    describe "collisions" do
      describe "define already defined method in a class" do
        context "redefine it after class declaration" do
          it "should has lower priority then method, declared in a class" do
            klass = Class.new
            klass.class_eval do
              def say_hi
                "hi from method" << " " << super
              end
            end

            InheritanceModuleEval.instance_eval_on klass do
              def say_hi
                "hi from eval"
              end
            end

            klass.new.say_hi.should == "hi from method hi from eval"
          end
        end

        context "redefine it before class declaration" do
          it "should has lower priority then method, declared in a class" do
            klass = Class.new
            klass.class_eval do
              InheritanceModuleEval.instance_eval_on self do
                def say_hi
                  "tiny hi"
                end
              end

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
              InheritanceModuleEval.instance_eval_on self do
                def say_hi
                  [5]
                end
              end

              InheritanceModuleEval.instance_eval_on self do
                def say_hi
                  [4] + super
                end
              end

              InheritanceModuleEval.instance_eval_on self do
                def say_hi
                  [3] + super
                end
              end

              InheritanceModuleEval.instance_eval_on self do
                def say_hi
                  [2] + super
                end
              end

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
              InheritanceModuleEval.instance_eval_on self do
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
        InheritanceModuleEval.send :get_module_for, "'hi'"
      end

      it "should raise ArgumentError if no code given" do
        ["", nil, []].each do |empty|
          expect{InheritanceModuleEval.send :get_module_for, empty}.to raise_error ArgumentError
        end
      end
    end

  end
end
