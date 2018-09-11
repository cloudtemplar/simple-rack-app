module TodoServices
  class Create
    attr_reader :form
    private :form

    def initialize(form)
      @form = form
    end

    def call
      Todo.create(form)
    end
  end
end
