
# STORY CARD

  def story_card(options={})
    before(:all) do
      array = []
      array << ["|", "  Who".bold, options[:who].white].join(' ')
      array << ["|", " What".bold, options[:what].white].join(' ')
      array << ["|", "  Why".bold, options[:why].white].join(' ')

      x = array.max { |s| s.length }.uncolorize.length
      s = "+" + ("-" * x)
      t = "STORY CARD:".light_blue
      puts nil, t, s, array, s, nil
    end
  end



#
# FEATURE INJECTION
#


  def ccontext(s, &b)
    context(_feature_injection_formatting("Context", s), &b)
  end

  def vision(s, &b)
    context(_feature_injection_formatting("Vision", s), &b)
  end

  def goal(s, &b)
    context(_feature_injection_formatting("Goal", s), &b)
  end

  def capability(s, &b)
    context(_feature_injection_formatting("Capability", s), &b)
  end

  def ffeature(s, &b)
    context(_feature_injection_formatting("Feature", s), &b)
  end

  def sstory(s, &b)
    context(_feature_injection_formatting("Story", s), &b)
  end

  def sscenario(s, &b)
    scenario(_feature_injection_formatting("Scenario", s), &b)
  end

  def _feature_injection_formatting(s1, s2)
    [s1.underline.light_white, s2].join(": ")
  end

  def goal_story(_goal, _capability, _feature, _story, &b)
    vision "Be a great auth library" do
      goal _goal do
        capability _capability do
          ffeature _feature do
            sstory _story, &b
          end
        end
      end
    end
  end

  def goal_feature(_goal, _capability, _feature, &b)
    vision "Be a great Rails User Registration Open Source Library" do
      goal _goal do
        capability _capability do
          ffeature _feature, &b
        end
      end
    end
  end
  
  # def feature_injection(*array, &b)
  #   list = [:_]

  #   yield &b
    
  # end





# FEATURE TERMS

  def feature_set(*args, &b)
    describe(*args, &b)
  end


# AGILE TERMS

# def epic(*args, &b)
#   describe(*args, &b)
# end
#
# def story(*args, &b)
#   describe(*args, &b)
# end



  # WWW

  def feature_www(s, options={}, &b)
    s = ["Feature:", s, www(options)]
    feature(s, &b)
  end

  def www(options={})
    r = []
    r << "\n    Who....: #{options[:who].light_black}"   if options[:who]
    r << "\n    What...: #{options[:what].light_black}"  if options[:what]
    r << "\n    Why....: #{options[:why].light_black}"   if options[:why]
    r << "\n    Where..: #{options[:where].light_black}" if options[:where]
    r.join('')
  end


    # WWW GROUPING

    def who(s, &b)
      describe("Who:", s.light_black, &b)
    end

    def what(s, &b)
      describe("What:", s.light_black, &b)
    end

    # def why(s, &b)
    #   describe("Why:", s.light_black, &b)
    # end

    # WWW SCENARIOS

    # def who_scenario(s, &b)
    #   scenario(s, &b)
    # end

    # def what_scenario(s, &b)
    #   scenario(s, &b)
    # end

    # def why_scenario(s, &b)
    #   scenario(s, &b)
    # end




