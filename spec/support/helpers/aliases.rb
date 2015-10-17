
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




