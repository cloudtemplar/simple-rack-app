module TodoServices
  class Destroy
    attr_reader :todo
    private :todo

    def initialize(todo)
      @todo = todo
    end

    def call
      todo.destroy
    end
  end
end
