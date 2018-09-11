module Routes
  module V1
    class Todos < Grape::API
      desc "Get a list of Todos"
      get :todos do
        present Todo.all
      end
    end
  end
end
