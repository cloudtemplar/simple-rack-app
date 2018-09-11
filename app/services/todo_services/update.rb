require 'pry'

module TodoServices
  class Update
    attr_reader :todo, :form
    private :todo, :form

    def initialize(todo, form)
      @todo = todo
      @form = form
    end

    def call
      todo.update(form)
    end
  end
end
