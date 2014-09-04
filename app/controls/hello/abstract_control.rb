module Hello
  class AbstractControl

    attr_reader :entity

    def initialize(controller, entity)
      @controller = controller
      @entity     = entity
    end

    def c
      @controller
    end
    
    def success
      raise NotImplementedError
    end

    def failure
      raise NotImplementedError
    end

  end
end