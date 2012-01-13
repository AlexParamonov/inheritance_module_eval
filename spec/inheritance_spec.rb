require "inheritance_module_eval"

describe InheritanceModuleEval do
  describe "add dynamic methods" do
    let(:test_class){ Class.new }
    let(:say_hi_block) do
      Proc.new do
        def say_hi
          "hi"
        end
      end
    end
    let(:say_hi_string) do
      %{
        def say_hi
          'hi'
        end
      }
    end

    it "should delegate to module_eval" do
      mock_module = mock(:mock_module)
      test_class.stub(:include)
      test_class.stub(:extend)
      Module.stub(:new).and_return(mock_module)

      mock_module.should_receive(:module_eval).once
      InheritanceModuleEval.instance_eval_on test_class, &say_hi_block

      mock_module.should_receive(:module_eval).once
      InheritanceModuleEval.class_eval_on test_class, &say_hi_block
    end

    describe "instance methods" do
      it "should eval a string" do
        InheritanceModuleEval.instance_eval_on test_class, say_hi_string
        test_class.new.should respond_to :say_hi
      end
      
      it "should eval a block" do
        InheritanceModuleEval.instance_eval_on test_class, &say_hi_block
        test_class.new.should respond_to :say_hi
      end
    end

    describe "class_methods" do
      it "should eval a string" do
        InheritanceModuleEval.class_eval_on test_class, say_hi_string
        test_class.should respond_to :say_hi
      end
      
      it "should eval a block" do
        InheritanceModuleEval.class_eval_on test_class, &say_hi_block
        test_class.should respond_to :say_hi
      end
    end


    describe "collisions" do
      describe "define already defined method in a class" do
        context "redefine it after class declaration" do
          it "should has lower priority then method, declared in a class" do
            test_class.class_eval do
              def say_hi
                "hi from method" << " and just super " << super
              end
            end

            InheritanceModuleEval.instance_eval_on test_class, &say_hi_block
            test_class.new.say_hi.should == "hi from method and just super hi"
          end
        end

        context "redefine it before class declaration" do
          it "should has lower priority then method, declared in a class" do
            test_class.class_eval do
              InheritanceModuleEval.instance_eval_on self do
                def say_hi
                  "tiny hi"
                end
              end

              def say_hi
                super.upcase
              end
            end
            test_class.new.say_hi.should == "TINY HI"
          end
        end

        describe "redefine as much as you want" do
          it "should push dynamic method down by the inheritance tree" do
            test_class.class_eval do
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
            test_class.new.say_hi.should == [1, 2, 3, 4, 5]
          end
        end

        describe "redefine it inside a module" do
          it "should push dynamic method before module and after class declaration" do
            test_module = Module.new
            test_module.module_eval do
              def say_hi
                "hi from module"
              end
            end

            test_class.class_eval do
              include test_module
              InheritanceModuleEval.instance_eval_on self do
                def say_hi
                  "hi from eval" << ", " << super
                end
              end

              def say_hi
                "hi from method" << ", " << super
              end
            end
            
            test_class.new.say_hi.should == "hi from method, hi from eval, hi from module"
          end
        end
      end
    end


    describe "#get_module_for" do
      it "should return Module" do
        expect{ InheritanceModuleEval.send :get_module_for, "'hi'"}.to_not raise_error
      end

      it "should raise ArgumentError if no code given" do
        ["", nil, []].each do |empty|
          expect{InheritanceModuleEval.send :get_module_for, empty}.to raise_error ArgumentError
        end
      end
    end

  end
end
